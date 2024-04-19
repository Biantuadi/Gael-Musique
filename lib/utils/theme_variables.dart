import 'package:flutter/material.dart';

class ThemeVariables {
  ThemeVariables._();

  static const Color primaryColor  = Color(0xFFDE901C);
  static const Color secondaryColor = Color(0xFFFFC54B);
  static const Color thirdColor = Color(0xFF2D2100);
  static const Color backgroundBlack = Color(0xFF161615);
  static const Color thirdColorBlack = Color(0xFF171717);
  static const Color blackfonce = Color.fromARGB(255, 9, 9, 9);
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
  static const songLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xf6aa01),
      Color(0xf6aa01),
      Color(0x3ff6aa01),
      Color(0x6c7e5600),
      Color(0xaf483100),
      Color(0xfa110e00),
      Color(0xfa030300),
    ],
    tileMode: TileMode.mirror,
  );

  static const primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [ThemeVariables.primaryColor, ThemeVariables.secondaryColor],
  );
  static const greenGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF056042),
      Color(0xFF003317)],
  );
  static const blueCardGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF1C49DE),
      Color(0xFF001B67)],
  );

}
