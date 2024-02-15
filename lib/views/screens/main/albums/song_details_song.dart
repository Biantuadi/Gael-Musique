import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SongDetailsScreen extends StatefulWidget{
  final Song song;
  const SongDetailsScreen({super.key, required this.song});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SongDetailsScreenState();
  }

}
class SongDetailsScreenState extends State<SongDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return  Consumer<SongProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ThemeVariables.thirdColorBlack,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: const Icon(Iconsax.arrow_left, color: Colors.white,),),
              title: Text(provider.currentAlbum!.title, style: Theme.of(context).textTheme.titleMedium,),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AssetImageWidget(imagePath: Assets.splashBgJPG, size: Size(size.width * 0.6, size.width *0.8)),
                    SizedBox(height: Dimensions.spacingSizeSmall,),
                    Text(provider.currentAlbum!.artist, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
                    Text(provider.currentSong!.title, style: Theme.of(context).textTheme.titleSmall,),
                    Row(
                      children: [
                        Text(provider.currentSong!.title, style: Theme.of(context).textTheme.titleSmall,),
                        Text(provider.currentSong!.title, style: Theme.of(context).textTheme.titleSmall,),
                      ],
                    ),
                    SizedBox(height: Dimensions.spacingSizeSmall,),
                    SvgPicture.asset(Assets.mediaSonSVG, width: size.width * 0.8,),
                    SizedBox(height: Dimensions.spacingSizeDefault,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.playPost();
                          },
                          icon: Icon(
                            CupertinoIcons.chevron_left,
                            size: Dimensions.iconSizeDefault,
                            //color: Colors.red,
                          ),
                        ),

                        IconButton(
                          color: ThemeVariables.primaryColor,
                          onPressed: () {
                                if(provider.audioPlayer.playing){
                                  provider.pauseSong();
                                }else{
                                  provider.playSong();
                                }
                          },
                          icon: Icon(
                            provider.audioPlayer.playing?
                                CupertinoIcons.pause_circle:
                            CupertinoIcons.play_circle_fill,
                            size: Dimensions.iconSizeExtraLarge * 2,
                            //color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            provider.playNext();
                          },
                          icon: Icon(
                            CupertinoIcons.right_chevron,
                            size: Dimensions.iconSizeDefault,
                            //color: repeatSong? Colors.red : null,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

          );
        }
    );
  }

}