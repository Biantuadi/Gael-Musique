import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SongWidget extends StatelessWidget{
  final Song song;
  final String albumImgUrl;
  final bool isPlaying;
  const SongWidget({super.key, required this.song, required this.albumImgUrl, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (){
        Provider.of<SongProvider>(context, listen: false).setCurrentSong(song);
        Provider.of<SongProvider>(context, listen: false).playSong();
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
        margin: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault, vertical: Dimensions.spacingSizeSmall/2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
            color: isPlaying? ThemeVariables.primaryColor.withOpacity(0.4): ThemeVariables.thirdColorBlack.withOpacity(0.3)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
           NetWorkImageWidget(size: Size(size.width * 0.15, size.width * 0.15), imageUrl: albumImgUrl??"", radius: Dimensions.radiusSizeDefault,),
           Expanded(child: Container(
              padding: EdgeInsets.only(left: Dimensions.spacingSizeSmall),
              width: size.width * 0.8 - Dimensions.spacingSizeSmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(song.title, style: Theme.of(context).textTheme.titleSmall,),
                      SizedBox(height: Dimensions.spacingSizeSmall/3,),
                      Text('${song.year}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
                      SizedBox(height: Dimensions.spacingSizeSmall/3,),
                      //Text('${duration}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),)
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: const Icon(Iconsax.heart4, color: Colors.white, ))

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}