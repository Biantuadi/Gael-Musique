import 'dart:math';

import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeAlbumCard extends StatelessWidget{
  final Album album;
  final Size screenSize;

  const HomeAlbumCard({super.key, required this.album, required this.screenSize});
  @override
  Widget build(BuildContext context) {
    ;
    String randomSong = "Random Song";
    if(album.songs.isNotEmpty){
      randomSong = album.songs[Random().nextInt(album.songs.length)]["title"];
      print("LES SONGS: ${album.songs[Random().nextInt(album.songs.length)]}");
    }

    return GestureDetector(
      onTap: (){
        Provider.of<SongProvider>(context, listen: false).setCurrentAlbum(album);
          Navigator.pushNamed(context, Routes.albumSongsScreen, arguments: album);
      },
      child: Container(
        height: screenSize.height/5,
        width: screenSize.width * 0.8,
        margin: EdgeInsets.only(right: Dimensions.spacingSizeDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault)
        ),
        child: Stack(
          children: [
            NetWorkImageWidget(size: Size(screenSize.width * 0.8, screenSize.height/4), imageUrl: album.imgAlbum??'', radius: Dimensions.radiusSizeDefault,),

            Opacity(
              opacity: 0.6,
              child: Container(
                height: screenSize.height/4,
                width: screenSize.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                    color: Colors.black
                ),
              ),
            ),
            Container(
              height: screenSize.height/4,
              width: screenSize.width * 0.8,
              padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(album.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, height: 1),),
                     SizedBox(height: Dimensions.spacingSizeExtraSmall,),
                     Row(
                       children: [
                         Icon(Iconsax.music, size: Dimensions.iconSizeExtraSmall, color: Colors.white,),
                         SizedBox(width: Dimensions.spacingSizeExtraSmall,),
                         Text(randomSong, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                       ],
                     ),
                   ],
                 ),
                  Row(
                    children: [
                      Text("Plus d'infos", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                      SizedBox(width: Dimensions.spacingSizeExtraSmall,),
                      Icon(Iconsax.arrow_right_34, color: Colors.white, size:Dimensions.iconSizeSmall ,),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}