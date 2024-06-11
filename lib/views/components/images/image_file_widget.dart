import 'dart:io';

import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class FileImageWidget extends StatelessWidget{
  final String imagePath;
  final Size size;
  final double? radius;
  const FileImageWidget({super.key, required this.imagePath, required this.size, this.radius});

  @override
  Widget build(BuildContext context) {
    File file = File(imagePath);
    file.exists().then((value){
      if(value){
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius??Dimensions.radiusSizeDefault),
          child: Image.file(file, width: size.width, height: size.height, fit: BoxFit.cover,),
        );
      }
    });

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
        color: ThemeVariables.thirdColorBlack
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.bug_report_outlined, color: Colors.white,),
    );

  }

}