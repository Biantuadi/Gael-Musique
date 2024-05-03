import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/data_base/database_client.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

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
  Future<bool> isOfflineMode()async{
    return  sharedPreferences.getBool(AppConfig.isOffLineMode)?? false;
  }
  setFirstTimeToFalse()async{
      await sharedPreferences.setBool(AppConfig.isFirstTime, false);
  }
  setOfflineMode(bool isOffline)async{
    await sharedPreferences.setBool(AppConfig.isOffLineMode, isOffline);
  }

  Future<bool> isTokenValid()async{
    String? tokenDateStr =  sharedPreferences.getString(AppConfig.sharedTokenDate);
    if(tokenDateStr != null){
      DateTime? tokenDate = DateTime.tryParse(tokenDateStr);
      if(tokenDate != null){
        bool isMoreThan150Days = !((DateTime.now().day - tokenDate.day) > 150 );
        return isMoreThan150Days;
      }

    }
    return false;
  }

  getDataBase()async{
    var db = DatabaseHelper.instance;
    Database database = await  db.database;
    return database;
  }

}