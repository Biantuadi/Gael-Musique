import 'dart:io';
import 'dart:math';
import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/repositories/song_repository.dart';
import 'package:Gael/utils/get_formatted_duration.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';


class SongProvider with ChangeNotifier{
  SongRepository songRepository;
  SongProvider({required this.songRepository});
  List<Album> allAlbums = [];
  List<Song> allSongs = [];
  List<Album>? albumsToShow;
  Album? currentAlbum;
  Song? currentSong;
  AudioPlayer audioPlayer = AudioPlayer();
  bool songIsPlaying = false;
  bool playNextSong = false;
  bool songStopped = true;
  bool playShuffledSong = false;
  Duration songDuration =  Duration.zero;
  Duration songPosition =  Duration.zero;
  String songDurationStr = "";
  String songPositionStr = "";
  double songPositionInDouble = 0;
  double songDurationInDouble = 0;
  bool isLoading = false;
  bool isLoadingData = false;
  bool downloadHadStarted = false;
  bool downloadedSuccessfully = false;
  bool errorOccuredWhileDownloading = false;
  String? currentDownloadingSongId;
  String? downloadError;
  int downloadPercent = 0;

  int songsTotalItems = 0;
  int songsCurrentPage = 0;
  int songsTotalPages = 0;



  playShuffled(){
    playShuffledSong = !playShuffledSong;
    notifyListeners();
  }
  setFirstSong(){
    if(currentAlbum != null){
      if(currentAlbum!.songs.isNotEmpty){
        currentSong = currentAlbum!.songs.first;
        audioPlayer.setUrl(currentSong!.songLink);
        onCompleted();
      }
    }
  }
  setCurrentSong(Song song)async{
    currentSong = song;
    isLoading = true;
    notifyListeners();
    bool audioFileExists = false;
    if (song.songLink != "" || song.bdSongPath != null){
      File audioFile = File(song.bdSongPath!);
      await audioFile.exists().then((value) {
          audioFileExists = true;
      });
      if(audioFileExists){
        await audioPlayer.setFilePath(song.bdSongPath!).then((value){
          onCompleted();
          getSongPosition();
          getSongDuration();
          songDurationInDouble = songDuration.inSeconds.toDouble();
        });
      }
    }
    else{
      await audioPlayer.setUrl(currentSong!.songLink).then((value){
        onCompleted();
        getSongPosition();
        getSongDuration();
        songDurationInDouble = songDuration.inSeconds.toDouble();
        downloadSongAudio(song: song);
      });
    }

    isLoading = false;
    notifyListeners();
  }
  onCompleted(){
    if(audioPlayer.duration != null){
      if(audioPlayer.duration!.inSeconds.toDouble() == audioPlayer.position.inSeconds.toDouble()){

        Random random = Random();
        if(currentAlbum != null){
          int indexOf = currentAlbum!.songs.indexOf(currentSong!);
          if(indexOf < currentAlbum!.songs.length - 2){
            currentSong = currentAlbum!.songs[indexOf+1];
          }else if (indexOf == currentAlbum!.songs.length-1){
            currentSong = currentAlbum!.songs[0];
          }
        }
        if(playShuffledSong){
          int index = random.nextInt( currentAlbum!.songs.length -1);
          currentSong = currentAlbum!.songs[index];
        }
      }
    }
    notifyListeners();
  }

  playSong()async{
    if(currentSong != null && !audioPlayer.playing || songStopped){
        audioPlayer.play();
        songIsPlaying = true;
    }
    notifyListeners();
  }
  pauseSong()async{
    if(currentSong != null && audioPlayer.playing){
      await audioPlayer.pause();
      songIsPlaying = false;
    }
    notifyListeners();
  }
  String getAnySongDuration(Song song){
    Duration d = Duration.zero;
    return getFormattedDuration(d);
  }

  playNext(){

    if(currentAlbum !=null){
      int indexOf = currentAlbum!.songs.indexOf(currentSong!);
      if(indexOf < currentAlbum!.songs.length - 2){
        currentSong = currentAlbum!.songs[indexOf+1];
      }else if (indexOf == currentAlbum!.songs.length-1){
        currentSong = currentAlbum!.songs[0];
      }
      audioPlayer.setUrl(currentSong!.songLink);
      audioPlayer.play();
    }
  }

  playPost(){

    if(currentAlbum !=null){
      int indexOf = currentAlbum!.songs.indexOf(currentSong!);
      if(indexOf > 1){
        currentSong = currentAlbum!.songs[indexOf-1];
      }else if (indexOf == 0){
        currentSong = currentAlbum!.songs.last;
      }
      audioPlayer.setUrl(currentSong!.songLink);
      audioPlayer.play();
    }
  }

  String getSongStrDuration(){
    songDurationStr = getFormattedDuration(audioPlayer.duration??songDuration);
    return songDurationStr;
  }
  String getSongStrPosition(){
    songPosition = audioPlayer.position ?? songPosition;
    songPositionStr = getFormattedDuration(songPosition);
    return songPositionStr;
  }
  String getSongReminder(Duration duration, Duration position){
    songPositionStr = getFormattedDuration(duration - position);

    return songPositionStr;
  }
  getSongDuration()async{
    audioPlayer.durationStream.listen((dur) {
      songDuration = dur??Duration.zero;
      notifyListeners();
    });
  }
  getSongPosition()async{
    audioPlayer.positionStream.listen((pos) {
      songPosition = pos;
      songPositionInDouble = songPosition.inSeconds.toDouble();
      notifyListeners();
    });
  }



  seekSong({required Duration position}){
    if(currentSong != null){
      audioPlayer.seek(position);
      notifyListeners();
    }
  }

  setCurrentAlbum(Album album){
    currentAlbum = album;
     }

  bool thisSongIsCurrent(Song song){
    if(currentSong != null){
      return song.id == currentSong!.id;
    }
    return false;
  }


  disposePlayer(){
    audioPlayer.dispose();
    notifyListeners();
  }


  incrementCurrentPage(){
    if(songsCurrentPage < songsTotalPages){
      songsCurrentPage++;
      getSongs();
    }
  }

  getSongs()async{
    if(songsCurrentPage>0){
      isLoadingData = true;
      notifyListeners();
    }
    Response response = await songRepository.getSongs(page: songsCurrentPage>0?songsCurrentPage:null );
    if(response.statusCode == 200){
      dynamic data = response.data["items"];
      songsTotalItems = response.data["totalItems"];
      songsCurrentPage = response.data["currentPage"];
      songsTotalPages = response.data["totalPages"];
      data.forEach((json){
        allSongs.add(Song.fromJson(json));
      });
      if(songsCurrentPage>0){
        isLoadingData = true;
        notifyListeners();
      }
      notifyListeners();
    }
  }
  getAlbums() async {
    Response response = await songRepository.getAlbums();

    if(response.statusCode == 200){
      dynamic data = response.data["items"];
      data.forEach((json){
        allAlbums.add(Album.fromJson(json:json));
      });

      albumsToShow = allAlbums;
      notifyListeners();
    }

  }

  Future<String> createFolderInAppDocDir(String folderName) async {
    final Directory? downloadsDir = await getExternalStorageDirectory();
    if(downloadsDir != null){

    }
    final Directory directory = Directory(path.join(downloadsDir!.path,folderName ));
    if (await directory.exists()) {
      return directory.path;
    } else {
      final Directory newDirectory = await directory.create(recursive: true);
      //final noMediaPath = path.join(directory.path, '.nomedia');
      //File(noMediaPath).create();
      return newDirectory.path;
    }
  }

  getPermission()async{
    var permission = await Permission.storage.status;
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if(permission.isGranted == false){
      if(Platform.isAndroid){
        AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
        int sdkVersion = androidDeviceInfo.version.sdkInt;
        if(sdkVersion >= 30){
          await Permission.audio.request();
        }else if(sdkVersion >= 30 && sdkVersion < 33){
          await Permission.storage.request();
        }else {
          await Permission.storage.request();
        }
      }else{
        permission =  await Permission.storage.request();
      }
    }
  }
  downloadSongAudio({required Song song})async{
    currentDownloadingSongId = song.id;
    notifyListeners();
    Response? response;
    String url = song.songLink;
    final regex = RegExp(r'\s+');
    String fileName = "${song.title.replaceAll(regex,"_")}.mp3";
    String filePath = "";
    await createFolderInAppDocDir("songs_audios").then((value) {
      filePath = path.join(value, fileName);
    });
    await getPermission();
    var permission = await Permission.audio.status;

    if(permission.isGranted){
      response = await download(url: url, savePath: filePath);

      if (response?.statusCode == 200){
        downloadedSuccessfully = true;
        downloadSuccessCallBack(song, filePath, response!);
      }else{
        downloadError = "Vous devez autoriser Le recueil a utiliser votre stockage";
        notifyListeners();
        downloadErrorCallBack();
      }
      notifyListeners();
    }else{
      permission = await Permission.storage.request();
      //downloadErrorCallBack();
    }
    downloadHadStarted = false;
    notifyListeners();
  }
  Future<Response?>download({required String url, required String savePath})async{
    downloadHadStarted = true;
    Dio dio = Dio();
    Uri uri = Uri.parse(url);
    notifyListeners();
    final response = dio.downloadUri(uri, savePath, onReceiveProgress: (receivedData,totalByte ){
      double percentDouble = receivedData * 100 / totalByte;
      downloadPercent = percentDouble.toInt();
      notifyListeners();
    });
    return response;
  }

  bool isCurrentDownloadingSongId(int id)=>id == currentDownloadingSongId;

  downloadSuccessCallBack(Song song, String filePath, Response response)async{
    downloadedSuccessfully = true;
    song.bdSongPath = filePath;
    await songRepository.upsertSong(song: song);
  }
  downloadErrorCallBack(){
    downloadedSuccessfully = false;
    errorOccuredWhileDownloading = true;
    notifyListeners();
  }

  resetDownloadVars(){
    downloadedSuccessfully = false;
    downloadHadStarted = false;
    errorOccuredWhileDownloading = false;
    downloadPercent = 0;
    currentDownloadingSongId = null;
    notifyListeners();
  }


}