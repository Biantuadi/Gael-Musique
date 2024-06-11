import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  SocketRepository({required this.sharedPreferences, required this.dioClient});


 Future<Response> getStreaming()async{
    Response response = await dioClient.get(AppConfig.streamingsUrl);
    return response;
 }

}