import 'dart:math';
import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/repositories/song_repository.dart';
import 'package:Gael/utils/get_formatted_duration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

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
    await audioPlayer.setUrl(currentSong!.songLink);
    onCompleted();
    getSongPosition();
    getSongDuration();
    songDurationInDouble = songDuration.inSeconds.toDouble();

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
        allAlbums.add(Album.fromJson(json));
      });

      albumsToShow = allAlbums;
      notifyListeners();
    }

  }


}