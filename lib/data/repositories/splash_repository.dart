import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepository{
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  SplashRepository({required this.sharedPreferences, required this.dioClient});

  Future<bool>isFirstTime()async{
     return  sharedPreferences.getBool(AppConfig.isFirstTime) ?? true;
  }

  setFirstTimeToFalse()async{
      await sharedPreferences.setBool(AppConfig.isFirstTime, false);
  }

}