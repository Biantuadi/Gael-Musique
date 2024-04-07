import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  ChatRepository({required this.sharedPreferences, required this.dioClient});


  Future<ApiResponse?> getUsers()async{
    Response response = await dioClient.get(AppConfig.usersUrl,);
    return ApiResponse(response: response);
  }

}