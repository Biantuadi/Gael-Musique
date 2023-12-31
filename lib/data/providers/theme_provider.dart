import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:Gael/data/repositories/theme_repository.dart';

class ThemeProvider with ChangeNotifier{
  ThemeRepository themeRepository;
  ThemeProvider({required this.themeRepository});
// THEME
  bool isDark = false;
  ThemeMode themeMode = ThemeMode.system;
  String _theme = Themes.system;
  String get theme => _theme;

  manageTheme(){
    if(_theme == Themes.light){
      isDark = false;
      themeMode = ThemeMode.light;
    }else if(_theme == Themes.dark){
      isDark = true;
      themeMode = ThemeMode.dark;
    }else{
      var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      if(Brightness.dark == brightness ){
        isDark = true;
      }else{
        isDark = false;
      }
      themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  setTheme(String value){
    _theme = value;
    themeRepository.setTheme(theme: _theme);
    manageTheme();
    notifyListeners();
  }

  getTheme() async{
     themeRepository.getTheme().then((value){
       _theme = value ?? _theme;
       notifyListeners();
       manageTheme();
     });
  }

  // PHONE SIZES IN DP
  double standardTabletScreenWidth = 600;
  double smallPhoneWidth = 320;
  double bigPhoneScreen = 480;
  double bigTabletScreen = 720;
  
}

class Themes{
  static String light = "light";
  static String dark = "dark";
  static String system = "system";
}

