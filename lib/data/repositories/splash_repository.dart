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
    return  sharedPreferences.getString(AppConfig.sharedToken);
  }
  Future<String?> getUserName()async{
    return  sharedPreferences.getString(AppConfig.sharedUserName);
  }
  Future<String?> getUserProfileUrl()async{
    return  sharedPreferences.getString(AppConfig.sharedProfileUrl);
  }
  Future<String?> getUserFirstName()async{
    return  sharedPreferences.getString(AppConfig.sharedFirstName);
  }

  Future<String?> getUserPhone()async{
    return  sharedPreferences.getString(AppConfig.sharedPhone);
  }
  Future<String?> getUserEmail()async{
    return  sharedPreferences.getString(AppConfig.sharedEmail);
  }
  Future<String?> getUserID()async{
    return  sharedPreferences.getString(AppConfig.sharedUserID);
  }
  Future<String?> getUserBio()async{
    return  sharedPreferences.getString(AppConfig.sharedUserBio);
  }
  setFirstTimeToFalse()async{
      await sharedPreferences.setBool(AppConfig.isFirstTime, false);
  }

  Future<bool> isTokenValid()async{
    String? tokenDateStr =  sharedPreferences.getString(AppConfig.sharedTokenDate);
    if(tokenDateStr != null){
      DateTime tokenDate = DateTime.parse(tokenDateStr);
      bool isMoreThanOneDay = (DateTime.now().day - tokenDate.day) > 1;
      return isMoreThanOneDay;
    }
    return false;
  }

}