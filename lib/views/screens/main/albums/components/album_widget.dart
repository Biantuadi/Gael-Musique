import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AlbumWidget extends StatelessWidget{
  final Album album;

  const AlbumWidget({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Routes.albumSongsScreen, arguments: album);
      },
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
            NetWorkImageWidget(size: Size(size.width * 0.2, size.width * 0.2), imageUrl: album.imgAlbum??"", radius: Dimensions.radiusSizeDefault,),
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
                      Text(album.title, style: Theme.of(context).textTheme.titleSmall,),
                      SizedBox(height: Dimensions.spacingSizeSmall/2,),
                      album.subtitle != ""?
                      Text(album.subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),) : SizedBox(height: 0,),
                      Text(album.artist, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                    width: size.width * 0.15,
                    decoration: BoxDecoration(
                      color: ThemeVariables.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),

                    ),
                    child: Text('${album.year}', style: Theme.of(context).textTheme.bodySmall,),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
class AlbumWidgetShimmer extends StatelessWidget{

  const AlbumWidgetShimmer({super.key,});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
      margin: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault, vertical: Dimensions.spacingSizeSmall/2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
        color: ThemeVariables.thirdColorBlack
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
              baseColor: ThemeVariables.thirdColor,
              highlightColor: Colors.white12,
              child: Container(
                height: size.width * 0.2,
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
                ),
              )
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
                    Shimmer.fromColors(
                        baseColor: ThemeVariables.thirdColor,
                        highlightColor: Colors.grey,
                        child: Container(
                          height: Dimensions.spacingSizeSmall,
                        )
                    ),
                    SizedBox(height: Dimensions.spacingSizeSmall/2,),
                    Shimmer.fromColors(
                        baseColor: ThemeVariables.thirdColor,
                        highlightColor: Colors.grey,
                        child: Container(
                          height: Dimensions.spacingSizeExtraSmall,
                        )
                    ),
                ],
                ),
                Shimmer.fromColors(
                    baseColor: ThemeVariables.thirdColor,
                    highlightColor: Colors.grey,
                    child:  Container(
                      padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
                      width: size.width * 0.15,
                      height: Dimensions.spacingSizeExtraSmall,
                      decoration: BoxDecoration(
                        color: ThemeVariables.primaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                      ),
                    )
                ),

              ],
            ),
          ))
        ],
      ),
    );
  }
}