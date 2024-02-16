import 'dart:math';
import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/repositories/song_repository.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
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
  List<Song>? currentAlbumSongs;
  Duration songDuration =  Duration.zero;
  Duration songPosition =  Duration.zero;
  String songDurationStr = "";
  String songPositionStr = "";
  String defaultSongUrl = "https://www.dropbox.com/s/v381wcr6ixsygrm/364%20C%27EST%20MON%20JOYEUX%20SERVICE.mp3?dl=1";
  PlayerController playerController =  PlayerController();

  String getFormattedDuration(Duration duration){
    String hours = duration.inHours.remainder(60).toString().padLeft(2,'0');
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2,'0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');


    if(duration.inHours < 1){
      return "$minutes:$seconds";
    }
    return "$hours:$minutes:$seconds";
  }

  playShuffled(){
    playShuffledSong = !playShuffledSong;
    notifyListeners();
  }
  setFirstSong(){
    if(currentAlbumSongs != null){
      if(currentAlbumSongs!.isNotEmpty){
        currentSong = currentAlbumSongs!.first;
        audioPlayer.setUrl(defaultSongUrl);
        onCompleted();
      }
    }
  }
  setCurrentSong(Song song){
    currentSong = song;
    audioPlayer.setUrl(defaultSongUrl);
    onCompleted();
    notifyListeners();
  }
  onCompleted(){
    if(audioPlayer.duration != null){
      if(audioPlayer.duration!.inSeconds.toDouble() == audioPlayer.position.inSeconds.toDouble()){
        int indexOf = currentAlbumSongs!.indexOf(currentSong!);
        Random random = Random();
        if(currentAlbumSongs!=null){
          if(indexOf < currentAlbumSongs!.length - 2){
            currentSong = currentAlbumSongs![indexOf+1];
          }else if (indexOf == currentAlbumSongs!.length-1){
            currentSong = currentAlbumSongs![0];
          }
        }
        if(playShuffledSong){
          int index = random.nextInt( currentAlbumSongs!.length -1);
          currentSong = currentAlbumSongs![index];
        }
      }
    }

  }

  playSong()async{
    if(currentSong != null && !audioPlayer.playing || songStopped){
        audioPlayer.play();
    }
  }
  pauseSong()async{
    if(currentSong != null && audioPlayer.playing){
      await audioPlayer.pause();
    }
  }
  String getAnySongDuration(Song song){
    //AudioPlayer player = AudioPlayer();
    //player.setUrl(defaultSongUrl);
    Duration d = Duration.zero;
    //d = player.duration ?? d;
    //player.dispose();
    return getFormattedDuration(d);
  }

  playNext(){
    int indexOf = currentAlbumSongs!.indexOf(currentSong!);
    if(currentAlbumSongs!=null){
      if(indexOf < currentAlbumSongs!.length - 2){
        currentSong = currentAlbumSongs![indexOf+1];
      }else if (indexOf == currentAlbumSongs!.length-1){
        currentSong = currentAlbumSongs![0];
      }
      audioPlayer.setUrl(defaultSongUrl);
      audioPlayer.play();
    }
  }

  playPost(){
    int indexOf = currentAlbumSongs!.indexOf(currentSong!);
    if(currentAlbumSongs!=null){
      if(indexOf > 1){
        currentSong = currentAlbumSongs![indexOf-1];
      }else if (indexOf == 0){
        currentSong = currentAlbumSongs!.last;
      }
      audioPlayer.setUrl(defaultSongUrl);
      audioPlayer.play();
    }
  }

  String getSongDuration(){
    songDurationStr = getFormattedDuration(audioPlayer.duration??songDuration);
    return songDurationStr;
  }
  String getSongPosition(){
    songPosition = audioPlayer.position ?? songPosition;
    songPositionStr = getFormattedDuration(songPosition);
    return songPositionStr;
  }
  String getSongReminder(Duration duration, Duration position){
    songPositionStr = getFormattedDuration(duration - position);

    return songPositionStr;
  }

  seekSong({required Duration position}){
    if(currentSong != null){
      audioPlayer.seek(position);
      notifyListeners();
    }
  }

  setCurrentAlbum(Album album){
    currentAlbum = album;
    currentAlbumSongs = allSongs.where((song) => song.album == album.id).toList();
    if(currentAlbumSongs!.isNotEmpty){
      //currentSong = currentAlbumSongs!.first;
    }

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
  getSongs()async{
    Response response = await songRepository.getSongs();
    //print("RESPONSE CODE:${response.statusCode} ");
    if(response.statusCode == 200){
      dynamic data = response.data["items"];
      // print("LA SONGS DATA: ${data[0]}");
      data.forEach((json){
        allSongs.add(Song.fromJson(json));
      });
      notifyListeners();

    }
  }
  getAlbums() async {
    Response response = await songRepository.getAlbums();
    print("LA STATUS CODE: ${response.statusCode}");
    print("LA STATUS MSG: ${response.statusMessage}");

    if(response.statusCode == 200){
      dynamic data = response.data["items"];
      //print("LA DATA: ${response.data}");
      data.forEach((json){
        allAlbums.add(Album.fromJson(json));
      });
      albumsToShow = allAlbums;
      notifyListeners();
    }

  }

}