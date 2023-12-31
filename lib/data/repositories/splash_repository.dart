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

  Future<String?> getUserToken()async{
    return  sharedPreferences.getString(AppConfig.token);
  }
  Future<String?> getUserName()async{
    return  sharedPreferences.getString(AppConfig.userFirstName);
  }
  Future<String?> getUserProfileUrl()async{
    return  sharedPreferences.getString(AppConfig.userProfileUrl);
  }
  Future<String?> getUserFirstName()async{
    return  sharedPreferences.getString(AppConfig.userFirstName);
  }

  setFirstTimeToFalse()async{
      await sharedPreferences.setBool(AppConfig.isFirstTime, false);
  }

}