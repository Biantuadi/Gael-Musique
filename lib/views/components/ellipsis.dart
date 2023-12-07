import 'package:flutter/material.dart';

Align buildEllipse({double? sizeWidth, double? sizeHeight}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Image.asset(
      "assets/images/gradient.png",
      fit: BoxFit.cover,
      width: sizeWidth,
      height: sizeHeight,
    ),
  );
}

// image svg

