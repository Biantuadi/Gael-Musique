import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  AuthRepository({required this.sharedPreferences, required this.dioClient});
}