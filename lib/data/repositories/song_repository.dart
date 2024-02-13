import 'package:Gael/data/api/client/dio_client.dart';
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
  Future<Response> getSongs() async {
    final response = await dioClient.get(AppConfig.songsUrl);
    return response;
  }
}