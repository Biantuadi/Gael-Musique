import 'package:flutter/material.dart';

class Dimensions {
  //static double SPACING_SIZE_EXTRA_EXTRA_SMALL = (screenSize.width >= bigTabletScreen)? 10 :(screenSize.width >= smallPhoneWidth)? 2.0 : 1;
  // ignore: deprecated_member_use
  static Size screenSize = MediaQueryData.fromView(WidgetsBinding.instance.window).size ;//MediaQuery.sizeOf(MainApp.navigatorKey.currentContext!);
  static double standardTabletScreenWidth = 600;
  static double smallPhoneWidth = 320;
  static double bigPhoneScreen = 480;
  static double bigTabletScreen = 720;
  static double spacingSizeExtraSmall = screenSize.width >= bigTabletScreen? 15: (screenSize.width >= smallPhoneWidth)? 5.0 : 2;
  static double spacingSizeSmall = screenSize.width >= bigTabletScreen? 20 : (screenSize.width >= smallPhoneWidth)? 10.0 : 5;
  static double spacingSizeDefault = screenSize.width >= bigTabletScreen? 25: (screenSize.width >= smallPhoneWidth)? 15.0 : 8 ;
  static double spacingSizeLarge = screenSize.width >= bigTabletScreen? 30: (screenSize.width >= smallPhoneWidth)? 20.0 : 10;
  static double sapcingSizeExtraLarge = screenSize.width >= bigTabletScreen? 35 : (screenSize.width >= smallPhoneWidth)? 25.0 : 15;

  static double radiusSizeDefault = screenSize.width >= bigTabletScreen? 20:  (screenSize.width >= smallPhoneWidth)? 12 : 7;
  static double radiusSizeExtraSmall = screenSize.width >= bigTabletScreen? 15: (screenSize.width >= smallPhoneWidth)? 5 : 3;
  static double radiusSizeSmall = screenSize.width >= bigTabletScreen?18: (screenSize.width >= smallPhoneWidth)?8 : 4;
  static double radiusSizeMedium = screenSize.width >= bigTabletScreen?22: (screenSize.width >= smallPhoneWidth)? 12 : 8;
  static double radiusSizeLarge = screenSize.width >= bigTabletScreen?24:  (screenSize.width >= smallPhoneWidth)? 14 : 10;
  static double radiusSizeExtraLarge =screenSize.width >= bigTabletScreen? 28: (screenSize.width >= smallPhoneWidth)?18 : 14;

  static double iconSizeExtraSmall = screenSize.width >= bigTabletScreen?22: (screenSize.width >= smallPhoneWidth)? 12.0 : 8;
  static double iconSizeSmall = screenSize.width >= bigTabletScreen? 28: (screenSize.width >= smallPhoneWidth)? 18.0 : 10;
  static double iconSizeDefault = screenSize.width >= bigTabletScreen?34: (screenSize.width >= smallPhoneWidth)? 24.0 : 16;
  static double iconSizeLarge = screenSize.width >= bigTabletScreen?42: (screenSize.width >= smallPhoneWidth)? 32.0 : 22;
  static double iconSizeExtraLarge = screenSize.width >= bigTabletScreen? 50: (screenSize.width >= smallPhoneWidth)? 40.0 : 30;

}