import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumsRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  AlbumsRepository({required this.sharedPreferences, required this.dioClient});

  Future<List<dynamic>> getAlbums() async {
    final response = await dioClient.get('/albums');
    print(response.data);
    return response.data;
  }
}