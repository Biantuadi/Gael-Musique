import 'package:Gael/data/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssetImageWidget extends StatefulWidget{
  final String imagePath;
  final Size size;
  final double? radius;
  const AssetImageWidget({super.key, required this.imagePath, required this.size, this.radius});

  @override
  State<StatefulWidget> createState() {
   return AssetImageWidgetState();
  }

}
class AssetImageWidgetState extends State<AssetImageWidget>{
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius??Provider.of<ThemeProvider>(context, listen: false).radiusSizeDefault),
      child: Image.asset(widget.imagePath, width: widget.size.width, height: widget.size.height, fit: BoxFit.cover,),
    );
  }

}