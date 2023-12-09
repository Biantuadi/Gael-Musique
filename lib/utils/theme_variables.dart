import 'package:flutter/material.dart';

class ThemeVariables {
  ThemeVariables._();

  static const Color primaryColor = Color(0xFFDE901C);
  static const Color secondaryColor = Color(0xFFFFC54B);
  static const Color backgroundBlack = Color(0xFF161615);
  static const Color thirdColorBlack = Color(0xFF161615);
  static const Color iconInactive = Color.fromRGBO(
      87, 87, 87, 0.8549019607843137);
  static  Color listChatTextColor = Colors.white.withOpacity(0.5);

  static const linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xaff6aa01),
      Color(0xaff6aa01),
      Color(0xafc78900),
      Color(0xafc78900),
      Color(0xfa805d00),
      Color(0xfa805d00),
    ],
    tileMode: TileMode.mirror,
  );

}
