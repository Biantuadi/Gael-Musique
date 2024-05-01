// ignore_for_file: avoid_print, must_be_immutable

import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget{
  double startPosition;
  double? width;
  double? height;
  CustomSlider({super.key, required this.startPosition, this.width, this.height});
  @override
  CustomSliderState createState()=>CustomSliderState();
}
class CustomSliderState extends State<CustomSlider>{
  double startPosition = 0;
  double value = 0;
  double sliderWidth = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
    onPanStart: (details){
        setState(() {
          startPosition = details.localPosition.dx;
        });
      },
      onPanUpdate: (details){
        double distance = details.localPosition.dx - startPosition;
        double width = size.width;
        double newValue = value + distance / (width * 100);
        newValue = newValue.clamp(0, 100);
        setState(() {
          value = newValue;
        });
        print("LA SIZE: ${value/ size.width * 100}");
      },
      onPanEnd: (details){
          print("LA SIZE: ${value/ size.width * 100}");
      },

      child: Container(
        color: Colors.white,
        width: widget.width?? size.width,
        child: Row(
          children: [
            Container(
              width: value/ size.width * 100,
              height: widget.height??1,
              color: ThemeVariables.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}