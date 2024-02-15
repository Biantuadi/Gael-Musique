import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SongWidget extends StatelessWidget{
  final Song song;
  const SongWidget({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
        margin: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault, vertical: Dimensions.spacingSizeSmall/2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
            color: ThemeVariables.thirdColorBlack
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // NetWorkImageWidget(size: Size(size.width * 0.2, size.width * 0.2), imageUrl: song.image??"", radius: Dimensions.radiusSizeDefault,),
            Container(
              padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                color: Colors.white

              ),
              child: const Icon(Iconsax.music, color: Colors.black,),
            ),
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
                      SizedBox(height: Dimensions.spacingSizeSmall/2,),
                      Text('${song.year}', style: Theme.of(context).textTheme.bodySmall,)

                    ],
                  ),
                  IconButton(onPressed: (){}, icon: Container(
                    padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                    width: size.width * 0.15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeVariables.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),

                    ),
                    child: Icon(Iconsax.play4),
                  ))

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}