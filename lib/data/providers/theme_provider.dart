import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:Gael/data/repositories/theme_repository.dart';
import 'package:Gael/main.dart';

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
       getSizes();
     });
  }

  // PHONE SIZES IN DP
  double standardTabletScreenWidth = 600;
  double smallPhoneWidth = 320;
  double bigPhoneScreen = 480;
  double bigTabletScreen = 720;


  //static double SPACING_SIZE_EXTRA_EXTRA_SMALL = (screenSize.width >= bigTabletScreen)? 10 :(screenSize.width >= smallPhoneWidth)? 2.0 : 1;
  double spacingSizeExtraSmall = 0;
  double spacingSizeSmall = 0;
  double spacingSizeDefault = 0;
  double spacingSizeLarge = 0;
  double sapcingSizeExtraLarge = 0;

  double radiusSizeDefault = 0;
  double radiusSizeExtraSmall = 0;
  double radiusSizeSmall = 0;
  double radiusSizeMedium = 0;
  double radiusSizeLarge = 0;
  double radiusSizeExtraLarge =0;

  double iconSizeExtraSmall = 0;
  double iconSizeSmall = 0;
  double iconSizeDefault = 0;
  double iconSizeLarge = 0;
  double iconSizeExtraLarge = 0;

  getSizes(){
    Size screenSize = MediaQuery.sizeOf(MainApp.navigatorKey.currentContext!);
    standardTabletScreenWidth = 600;
    smallPhoneWidth = 320;
    bigPhoneScreen = 480;
    bigTabletScreen = 720;

    spacingSizeExtraSmall = screenSize.width >= bigTabletScreen? 15: (screenSize.width >= smallPhoneWidth)? 5.0 : 2;
    spacingSizeSmall = screenSize.width >= bigTabletScreen? 20 : (screenSize.width >= smallPhoneWidth)? 10.0 : 5;
    spacingSizeDefault = screenSize.width >= bigTabletScreen? 25: (screenSize.width >= smallPhoneWidth)? 15.0 : 8 ;
    spacingSizeLarge = screenSize.width >= bigTabletScreen? 30: (screenSize.width >= smallPhoneWidth)? 20.0 : 10;
    sapcingSizeExtraLarge = screenSize.width >= bigTabletScreen? 35 : (screenSize.width >= smallPhoneWidth)? 25.0 : 15;

    radiusSizeDefault = screenSize.width >= bigTabletScreen? 20:  (screenSize.width >= smallPhoneWidth)? 10 : 6;
    radiusSizeExtraSmall = screenSize.width >= bigTabletScreen? 15: (screenSize.width >= smallPhoneWidth)? 5 : 3;
    radiusSizeSmall = screenSize.width >= bigTabletScreen?18: (screenSize.width >= smallPhoneWidth)?8 : 4;
    radiusSizeMedium = screenSize.width >= bigTabletScreen?22: (screenSize.width >= smallPhoneWidth)? 12 : 8;
    radiusSizeLarge = screenSize.width >= bigTabletScreen?24:  (screenSize.width >= smallPhoneWidth)? 14 : 10;
    radiusSizeExtraLarge =screenSize.width >= bigTabletScreen? 28: (screenSize.width >= smallPhoneWidth)?18 : 14;

    iconSizeExtraSmall = screenSize.width >= bigTabletScreen?22: (screenSize.width >= smallPhoneWidth)? 12.0 : 8;
    iconSizeSmall = screenSize.width >= bigTabletScreen? 28: (screenSize.width >= smallPhoneWidth)? 18.0 : 10;
    iconSizeDefault = screenSize.width >= bigTabletScreen?34: (screenSize.width >= smallPhoneWidth)? 24.0 : 16;
    iconSizeLarge = screenSize.width >= bigTabletScreen?42: (screenSize.width >= smallPhoneWidth)? 32.0 : 22;
    iconSizeExtraLarge = screenSize.width >= bigTabletScreen? 50: (screenSize.width >= smallPhoneWidth)? 40.0 : 30;

  }

}

class Themes{
  static String light = "light";
  static String dark = "dark";
  static String system = "system";
}

