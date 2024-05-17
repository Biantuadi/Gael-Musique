import 'dart:typed_data';

import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class Base64ImageWidget extends StatefulWidget{
  final String base64String;
  final Size size;
  final double? radius;
  const Base64ImageWidget({super.key, required this.base64String, required this.size, this.radius});

  @override
  State<StatefulWidget> createState() {
   return Base64ImageWidgetState();
  }

}
class Base64ImageWidgetState extends State<Base64ImageWidget>{
  @override
  Widget build(BuildContext context) {
    if(!widget.base64String.toLowerCase().contains("data:application/octet-stream;base64") && widget.base64String.length < 100){
        return NetWorkImageWidget(imageUrl: widget.base64String, size: widget.size);
    }
    Uint8List bytes = base64Decode(widget.base64String.substring(widget.base64String.indexOf(',')+1));
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius??Dimensions.radiusSizeDefault),
        child: Image.memory(bytes, width: widget.size.width/1000, height: widget.size.height, fit: BoxFit.cover,),
      ),
    );
  }

}