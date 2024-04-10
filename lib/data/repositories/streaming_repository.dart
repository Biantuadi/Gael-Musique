import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreamingRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  StreamingRepository({required this.sharedPreferences, required this.dioClient});


 Future<Response> getStreaming({int? page})async{
    Response response = await dioClient.get(AppConfig.streamingsUrl, queryParameters: {
      "page":page
    });
    return response;
  }

}