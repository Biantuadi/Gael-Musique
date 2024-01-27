import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/models/album_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  AlbumsRepository({required this.sharedPreferences, required this.dioClient});

  Future<List<Album>> getAlbums() async {
    final response = await dioClient.get('/albums');
    final albums = (response.data as List).map((album) => Album.fromJson(album)).toList();
    return albums;
  }
}