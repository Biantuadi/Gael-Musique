import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/views/components/image_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeAlbumCard extends StatelessWidget{
  final String imagePath;
  final String title;
  final String randomSongTitle;
  final Size screenSize;

  const HomeAlbumCard({super.key, required this.title, required this.imagePath, required this.randomSongTitle, required this.screenSize});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      height: screenSize.height/4,
      width: screenSize.width * 0.8,
      margin: EdgeInsets.only(right: themeProvider.spacingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(themeProvider.radiusSizeDefault)
      ),
      child: Stack(
        children: [
          AssetImageWidget(size: Size(screenSize.width * 0.8, screenSize.height/4), imagePath: imagePath, radius: themeProvider.radiusSizeDefault,),
          Opacity(
            opacity: 0.3,
            child: Container(
              height: screenSize.height/4,
              width: screenSize.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(themeProvider.radiusSizeDefault),
                  color: Colors.black
              ),
            ),
          ),
          Container(
            height: screenSize.height/4,
            width: screenSize.width * 0.8,
            padding: EdgeInsets.all(themeProvider.spacingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                   SizedBox(height: themeProvider.spacingSizeExtraSmall,),
                   Row(
                     children: [
                       Icon(Iconsax.music, size: themeProvider.iconSizeExtraSmall,),
                       SizedBox(width: themeProvider.spacingSizeExtraSmall,),
                       Text(randomSongTitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                     ],
                   ),
                 ],
               ),
                Row(
                  children: [

                    Text("Plus d'infos", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                    SizedBox(width: themeProvider.spacingSizeExtraSmall,),
                    Icon(Iconsax.arrow_right_34, color: Colors.white, size:themeProvider.iconSizeSmall ,),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}