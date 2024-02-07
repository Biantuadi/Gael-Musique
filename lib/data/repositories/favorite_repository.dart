import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  FavoriteRepository({required this.sharedPreferences, required this.dioClient});
}