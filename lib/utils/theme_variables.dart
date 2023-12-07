import 'package:flutter/material.dart';

class ThemeVariables {
  ThemeVariables._();

  static const Color primaryColor = Color(0xFFDE901C);
  static const Color secondaryColor = Color(0xFFFFC54B);
  static const Color backgroundBlack = Color(0xFF161615);
  static const Color thirdColorBlack = Color(0xFF161615);
  static const Color iconInactive = Color.fromRGBO(87, 87, 87, 0.529);
  static  Color listChatTextColor = Colors.white.withOpacity(0.5);

  static const linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Color(0xafffb002),
      Color(0xfacc9200),
      Color(0xaf7a5400),
    ],
    tileMode: TileMode.mirror,
  );

}
