import 'package:flutter/material.dart';

Align buildEllipse({ double? sizeWidth,  double? sizeHeight}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Image.asset(
      "assets/images/Ellipse.png",
      fit: BoxFit.cover,
      width: sizeWidth,
      height: sizeHeight,
    ),
  );
}
