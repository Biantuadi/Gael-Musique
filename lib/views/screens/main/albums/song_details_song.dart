import 'dart:math';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'components/audio_wave.dart';


class SongDetailsScreen extends StatefulWidget{
  const SongDetailsScreen({super.key,});

  @override
  State<StatefulWidget> createState() {
    return SongDetailsScreenState();
  }

}
class SongDetailsScreenState extends State<SongDetailsScreen>{
  final List<double> values = [];
  double vol = 0;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var rng = new Random();
    for (var i = 0; i < 100; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
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
              body: Stack(
                alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: size.height * .8,
                  width: size.width,
                  decoration:const  BoxDecoration(
                    gradient: ThemeVariables.songLinearGradient
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NetWorkImageWidget(size: Size(size.width * 0.8, size.width *0.6), imageUrl: provider.currentAlbum!.imgAlbum??'', radius: Dimensions.radiusSizeDefault,),
                          SizedBox(height: Dimensions.spacingSizeSmall,),
                          Text(provider.currentAlbum!.artist, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.primaryColor),),
                          Text(provider.currentSong!.title, style: Theme.of(context).textTheme.titleMedium,),
                          SizedBox(height: Dimensions.spacingSizeSmall,),
                          Container(
                            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                optionWidget(text: 'Aimer', iconData: Iconsax.heart4),
                                optionWidget(text: 'Playlist', iconData: Iconsax.music_playlist),
                                optionWidget(text: 'Télécharger', iconData: Iconsax.check),
                                optionWidget(text: 'Partager', iconData: Iconsax.share),

                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.spacingSizeSmall,),
                          Container(
                            width: size.width,
                            height: size.width / 6,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault),
                            child: provider.isLoading? const CircularProgressIndicator(
                              strokeWidth: 4,
                              color: ThemeVariables.primaryColor,
                            ): Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                AudioWaves(
                                  screenWidth: size.width - 2* Dimensions.spacingSizeDefault,
                                  maxHeight: size.height /15,
                                  songIsPlaying: provider.audioPlayer.playing,
                                  songPosition:provider.songPosition.inSeconds.toDouble() != 0.0?((provider.songPosition.inSeconds.toDouble()-1)): provider.songPositionInDouble,
                                  totalDuration: provider.audioPlayer.duration!.inSeconds.toDouble(),
                                ),
                                SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: size.width / 6,
                                      trackShape: const RectangularSliderTrackShape(),
                                      thumbShape: const RoundSliderThumbShape(),
                                      activeTrackColor: Colors.transparent,
                                      thumbColor: Colors.transparent,
                                      inactiveTrackColor: Colors.transparent,

                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: 1.15,
                                      child: Slider(
                                        min: 0,
                                        max:provider.audioPlayer.duration!.inSeconds.toDouble(),
                                        thumbColor: Colors.transparent,
                                        inactiveColor: Colors.transparent,
                                        activeColor: Colors.transparent,
                                        value:provider.songPosition.inSeconds.toDouble() != 0.0?((provider.songPosition.inSeconds.toDouble()-1)): provider.songPositionInDouble,
                                        onChanged: (double value) {
                                          setState(() {
                                            if(provider.songPosition.inSeconds.toDouble() < provider.songDuration.inSeconds.toDouble()){
                                              provider.audioPlayer.seek(Duration(seconds: value.toInt()));
                                            }
                                          });

                                        },
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(provider.getSongStrPosition(), style: Theme.of(context).textTheme.titleSmall,),
                                Text("-${provider.getSongReminder(provider.audioPlayer.duration ?? Duration.zero , provider.audioPlayer.position)}", style: Theme.of(context).textTheme.titleSmall,),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.spacingSizeDefault,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  //provider.playPost();
                                },
                                icon: Icon(
                                Iconsax.menu4,
                                  size: Dimensions.iconSizeDefault,
                                  //color: Colors.red,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      provider.playPost();
                                    },
                                    icon: Icon(
                                      Iconsax.previous,
                                      size: Dimensions.iconSizeDefault,
                                      //color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    color: ThemeVariables.primaryColor,
                                    onPressed: () async{
                                      if(provider.audioPlayer.playing){
                                        provider.pauseSong();
                                      }else{
                                        provider.playSong();
                                      }
                                    },
                                    icon: Icon(
                                      provider.songIsPlaying?
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
                                      Iconsax.next,
                                      size: Dimensions.iconSizeDefault,
                                      //color: repeatSong? Colors.red : null,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  //provider.playPost();
                                },
                                icon: Icon(
                                  Iconsax.shuffle,
                                  size: Dimensions.iconSizeDefault,
                                  //color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                    ),
                  ),
                ),
              ],
            ),

          );
        }
    );
  }

  Widget optionWidget({required String text, required IconData iconData}){
    return Column(
      children: [
        Icon(iconData, size: Dimensions.iconSizeSmall,),
        SizedBox(height: Dimensions.spacingSizeExtraSmall,),
        Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.bold),)
      ],
    );
  }

}