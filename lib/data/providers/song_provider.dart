import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/repositories/song_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SongProvider with ChangeNotifier{
  SongRepository songRepository;
  SongProvider({required this.songRepository});
  List<Album> allAlbums = [];
  List<Song> allSongs = [];
  List<Album>? albumsToShow;
  getSongs()async{
    Response response = await songRepository.getSongs();
    //print("RESPONSE CODE:${response.statusCode} ");
    if(response.statusCode == 200){
      dynamic data = response.data;

      //print("LA SONGS DATA: ${data[0]}");
      data.forEach((json){
        allSongs.add(Song.fromJson(json));
      });
      notifyListeners();
    }
  }
  getAlbums() async {
    Response response = await songRepository.getAlbums();
    if(response.statusCode == 200){
      dynamic data = response.data;
      data.forEach((json){
        allAlbums.add(Album.fromJson(json));
      });
      albumsToShow = allAlbums;
      notifyListeners();
    }

  }
}