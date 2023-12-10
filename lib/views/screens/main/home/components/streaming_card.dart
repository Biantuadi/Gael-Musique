import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/views/components/image_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamingCard extends StatelessWidget{
  final String imagePath;
  final String title;
  final double size;
  const StreamingCard({super.key ,required this.title, required this.imagePath, required this.size});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      //height: size * 3/2,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(themeProvider.radiusSizeDefault)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: [
          AssetImageWidget(size: Size(size, size * 4/3), imagePath: imagePath,),
          SizedBox(height: themeProvider.spacingSizeSmall,),
          SizedBox(
            width: size,
            child: Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white), overflow: TextOverflow.clip, maxLines: 2, textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}