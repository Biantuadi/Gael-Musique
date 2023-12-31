import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreamRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  StreamRepository({required this.sharedPreferences, required this.dioClient});
}