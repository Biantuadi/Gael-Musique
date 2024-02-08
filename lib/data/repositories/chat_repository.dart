import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  ChatRepository({required this.sharedPreferences, required this.dioClient});
}