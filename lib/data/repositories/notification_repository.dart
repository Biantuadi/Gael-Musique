import 'package:Gael/data/api/client/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepository{
    SharedPreferences sharedPreferences;
    DioClient dioClient;
    NotificationRepository({required this.sharedPreferences, required this.dioClient});
}