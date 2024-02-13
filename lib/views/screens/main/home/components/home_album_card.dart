import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeAlbumCard extends StatelessWidget{
  final Album album;
  final Size screenSize;

  const HomeAlbumCard({super.key, required this.album, required this.screenSize});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
              opacity: 0.3,
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
                     Text(album.title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                     SizedBox(height: Dimensions.spacingSizeExtraSmall,),
                     Row(
                       children: [
                         Icon(Iconsax.music, size: Dimensions.iconSizeExtraSmall,),
                         SizedBox(width: Dimensions.spacingSizeExtraSmall,),
                         Text('random title', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
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