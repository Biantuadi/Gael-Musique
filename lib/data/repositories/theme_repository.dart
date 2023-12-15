import 'package:Gael/utils/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository{
  SharedPreferences sharedPreferences;
  ThemeRepository({required this.sharedPreferences});

  Future<String?> getTheme()async{
    return sharedPreferences.getString(AppConfig.appTheme);
  }
  Future<void> setTheme({required String theme})async{
    await sharedPreferences.setString(AppConfig.appTheme, theme);
  }

}