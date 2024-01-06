import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  SongRepository({required this.sharedPreferences, required this.dioClient});
}