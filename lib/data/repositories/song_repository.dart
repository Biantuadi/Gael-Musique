import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/data_base/database_client.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  SongRepository({required this.sharedPreferences, required this.dioClient});
  Future<Response> getAlbums() async {
    final response = await dioClient.get(AppConfig.albumsUrl);
    return response;
  }
  Future<Response> getSongs({int? page}) async {
    final response = await dioClient.get(AppConfig.songsUrl, queryParameters: {"page": page});
    return response;
  }

  Future<List<Song>> getSongFromDb() async{
    List<Song> songs = [];
    var db = DatabaseHelper.instance;
    await db.fetchSongs().then(
            (value){
          songs = value;
        }
    );
    return songs;
  }
  upsertSong({required Song song})async{
    var db = DatabaseHelper.instance;
    db.upsertSong(song);
  }

  deleteSong({required String songId}){
    var db = DatabaseHelper.instance;
    db.deleteSong(songId);
  }


}