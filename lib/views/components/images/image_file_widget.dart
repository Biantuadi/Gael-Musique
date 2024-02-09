import 'dart:io';

import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';

class FileImageWidget extends StatefulWidget{
  final File imageFile;
  final Size size;
  final double? radius;
  const FileImageWidget({super.key, required this.imageFile, required this.size, this.radius});

  @override
  State<StatefulWidget> createState() {
    return FileImageWidgetState();
  }

}
class FileImageWidgetState extends State<FileImageWidget>{
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius??Dimensions.radiusSizeDefault),
      child: Image.file(widget.imageFile, width: widget.size.width, height: widget.size.height, fit: BoxFit.cover,),
    );
  }

}