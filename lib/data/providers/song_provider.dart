import 'dart:io';
import 'dart:math';
import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/repositories/song_repository.dart';
import 'package:Gael/utils/download_utils.dart';
import 'package:Gael/utils/get_formatted_duration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
// ignore: depend_on_referenced_packages
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
  String? audioPLayerError;
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

  String getAlbumCoverUrl (String albumID){
    String cover = "";
    if(allAlbums.where((album) => album.id == albumID).isNotEmpty){
      cover = allAlbums.where((album) => album.id == albumID).first.imgAlbum??'';
    }
    return cover;
  }

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
  setCurrentSong({required Song song, required Function onError})async{
    audioPLayerError = null;
    isLoading = true;
    notifyListeners();
    bool audioFileExists = false;
    currentAlbum = allAlbums.firstWhere((album) => album.id == song.album);
    if(currentSong != song){
      currentSong = song;

     if (song.songLink != "" && song.bdSongPath != null){
       File audioFile = File(song.bdSongPath??'-');
       await audioFile.exists().then((value) {
         audioFileExists = value;
       });
       if(audioFileExists){
         try{
           await audioPlayer.setFilePath(song.bdSongPath!).then((value){
             onCompleted();
             getSongPosition();
             getSongDuration();
             songDurationInDouble = songDuration.inSeconds.toDouble();
           });
         }catch (e){
           onAudioError(song, onError);
         }
       }
       else{
         try{
           await audioPlayer.setUrl(currentSong!.songLink).then((value){
             onCompleted();
             getSongPosition();
             getSongDuration();
             songDurationInDouble = songDuration.inSeconds.toDouble();
           });
         }catch (e){
           try{
             await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(currentSong!.songLink))).then((value){
               onCompleted();
               getSongPosition();
               getSongDuration();
               songDurationInDouble = songDuration.inSeconds.toDouble();
             });
           }
           catch (e){
             onAudioError(song, onError);
           }
         }
       }
     }
     else {
       try {
         await audioPlayer.setUrl(currentSong!.songLink).then((value) {
           onCompleted();
           getSongPosition();
           getSongDuration();
           songDurationInDouble = songDuration.inSeconds.toDouble();
         });
       } catch (e) {
         try {
           await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(currentSong!.songLink))).then((value) {
             onCompleted();
             getSongPosition();
             getSongDuration();
             songDurationInDouble = songDuration.inSeconds.toDouble();
           });
         }
         catch (e) {
           onAudioError(song, onError);
         }


   }}
    isLoading = false;
    notifyListeners();
  }}
  onAudioError(Song song, Function onError){
    audioPLayerError =
    "L'audio player rencontre un problème, veillez réessayer";
    onError(audioPLayerError);
    songIsPlaying = false;
    downloadSongAudio(song: song, onSuccess: () {});
    songDurationInDouble = 0;
    songPositionInDouble= 0;
    songDuration = Duration.zero;
    songPosition = Duration.zero;
    songIsPlaying =false;
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
    songPosition = audioPlayer.position;
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
      getSongsFromApi();
    }
  }

  getSongsFromDB()async{
    allSongs = await songRepository.getSongsFromDb();
    notifyListeners();
  }


  getAlbumsFromDB()async{
    allAlbums = await songRepository.getAlbumsFromDb();
    notifyListeners();
  }

  getSongsFromApi()async{
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
      data.forEach((json)async{
        allSongs.add(Song.fromJson(json));
        await songRepository.upsertSong(song: Song.fromJson(json));
      });

      isLoadingData = false;
      notifyListeners();
    }
  }
  getAlbums() async {
    Response response = await songRepository.getAlbums();
    if(response.statusCode == 200){
      dynamic data = response.data["items"];
      data.forEach((json)async{
        allAlbums.add(Album.fromJson(json:json));
        await songRepository.upsertAlbum(album: Album.fromJson(json:json));
      });

      albumsToShow = allAlbums;
      notifyListeners();
    }

  }




  downloadSongAudio({required Song song, required VoidCallback onSuccess})async{
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
      response = await download(url: url, savePath: filePath, onDownloading: (receivedData,totalByte ){
        double percentDouble = receivedData * 100 / totalByte;
        downloadPercent = percentDouble.toInt();
        notifyListeners();
      });

      if (response?.statusCode == 200){
        downloadedSuccessfully = true;
        onSuccessSongDownload(response!, audioPath: filePath, song: song);
        onSuccess();
      }else{
        downloadError = "Vous devez autoriser L'app à utiliser votre stockage";
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

  // ignore: unrelated_type_equality_checks
  bool isCurrentDownloadingSongId(int id)=>id == currentDownloadingSongId;

  onSuccessSongDownload(Response response, {required Song song, String? audioPath, String? imagePath})async{
    downloadedSuccessfully = true;
    if(audioPath != null){
      song.bdSongPath = audioPath;
    }
    if(imagePath != null){
      song.bdCoverPath = imagePath;
    }

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

  downloadSongCover(Song song)async{
    String url = song.image;
    final regex = RegExp(r'\s+');
    String fileName = "${song.title.replaceAll(regex,"_")}.jpg";
    String filePath = "";
    await createFolderInAppDocDir("songs-images").then((value) {
      filePath = path.join(value, fileName);
    });
    await getPermission();
    var permission = await Permission.photos.status;
    Response? response;
    if(permission.isGranted){
      response = await download(url: url, savePath: filePath, onDownloading: (receivedData,totalByte ){
        double percentDouble = receivedData * 100 / totalByte;
        downloadPercent = percentDouble.toInt();
        notifyListeners();
      });

      if (response?.statusCode == 200){
        downloadedSuccessfully = true;
        onSuccessSongDownload( response!, song: song,imagePath:filePath,);
      }else{
        downloadError = "Vous devez autoriser l'app à utiliser votre stockage";
        notifyListeners();
        downloadErrorCallBack();
      }
      notifyListeners();
    }else{
      permission = await Permission.storage.request();
      //downloadErrorCallBack();
    }
  }

  downloadAlbumCover(Album album)async{
    String url = album.imgAlbum??'';
    final regex = RegExp(r'\s+');
    String fileName = "${album.title.replaceAll(regex,"_")}.jpg";
    String filePath = "";
    await createFolderInAppDocDir("album-images").then((value) {
      filePath = path.join(value, fileName);
    });
    await getPermission();
    var permission = await Permission.photos.status;
    Response? response;
    if(permission.isGranted){
      response = await download(url: url, savePath: filePath, onDownloading: (receivedData,totalByte ){
        double percentDouble = receivedData * 100 / totalByte;
        downloadPercent = percentDouble.toInt();
        notifyListeners();
      });

      if (response?.statusCode == 200){
        downloadedSuccessfully = true;
        album.bdImgAlbum = filePath;
        await songRepository.upsertAlbum(album: album);
      }else{
        downloadError = "Vous devez autoriser l'app à utiliser votre stockage";
        notifyListeners();
        downloadErrorCallBack();
      }
      notifyListeners();
    }else{
      permission = await Permission.storage.request();
      //downloadErrorCallBack();
    }
  }


}