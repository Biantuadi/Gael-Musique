import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/data_base/database_client.dart';
import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/models/event_ticket_model.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodCastsRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  PodCastsRepository({required this.sharedPreferences, required this.dioClient});

  Future<Response> gePodcasts()async{
    Response response = await dioClient.get(AppConfig.podcastsUrl);
    return response;
  }
  Future<String?> getUserID()async{
    return  sharedPreferences.getString(AppConfig.sharedUserID);
  }

}