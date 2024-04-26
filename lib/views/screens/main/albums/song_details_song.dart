import 'dart:math';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    var rng = Random();
    for (var i = 0; i < 100; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
    return  Consumer2<SongProvider, StreamingProvider>(
        builder: (BuildContext context, songProvider,streamingProvider, Widget? child) {
          if(streamingProvider.streamingController.value.isPlaying ){
            streamingProvider.pauseStreamingVideo();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ThemeVariables.thirdColorBlack,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: const Icon(Iconsax.arrow_left, color: Colors.white,),),
              title: Text(songProvider.currentAlbum!.title, style: Theme.of(context).textTheme.titleMedium,),
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
                          NetWorkImageWidget(size: Size(size.width * 0.8, size.width *0.6), imageUrl: songProvider.currentAlbum!.imgAlbum??'', radius: Dimensions.radiusSizeDefault,),
                          SizedBox(height: Dimensions.spacingSizeSmall,),
                          Text(songProvider.currentAlbum!.artist, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.primaryColor),),
                          Text(songProvider.currentSong!.title, style: Theme.of(context).textTheme.titleMedium,),
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
                            child: songProvider.isLoading? const CircularProgressIndicator(
                              strokeWidth: 4,
                              color: ThemeVariables.primaryColor,
                            ): Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                AudioWaves(
                                  screenWidth: size.width - 2* Dimensions.spacingSizeDefault,
                                  maxHeight: size.height /15,
                                  songIsPlaying: songProvider.audioPlayer.playing,
                                  songPosition:songProvider.songPosition.inSeconds.toDouble() != 0.0?((songProvider.songPosition.inSeconds.toDouble()-1)): songProvider.songPositionInDouble,
                                  totalDuration: songProvider.audioPlayer.duration!.inSeconds.toDouble(),
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
                                        max:songProvider.audioPlayer.duration!.inSeconds.toDouble(),
                                        thumbColor: Colors.transparent,
                                        inactiveColor: Colors.transparent,
                                        activeColor: Colors.transparent,
                                        value:songProvider.songPosition.inSeconds.toDouble() != 0.0?((songProvider.songPosition.inSeconds.toDouble()-1)): songProvider.songPositionInDouble,
                                        onChanged: (double value) {
                                          setState(() {
                                            if(songProvider.songPosition.inSeconds.toDouble() < songProvider.songDuration.inSeconds.toDouble()){
                                              songProvider.audioPlayer.seek(Duration(seconds: value.toInt()));
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
                                Text(songProvider.getSongStrPosition(), style: Theme.of(context).textTheme.titleSmall,),
                                Text("-${songProvider.getSongReminder(songProvider.audioPlayer.duration ?? Duration.zero , songProvider.audioPlayer.position)}", style: Theme.of(context).textTheme.titleSmall,),
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
                                      songProvider.playPost();
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
                                      if(songProvider.audioPlayer.playing){
                                        songProvider.pauseSong();
                                      }else{
                                        songProvider.playSong();
                                      }
                                    },
                                    icon: Icon(
                                      songProvider.songIsPlaying?
                                      CupertinoIcons.pause_circle:
                                      CupertinoIcons.play_circle_fill,
                                      size: Dimensions.iconSizeExtraLarge * 2,
                                      //color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      songProvider.playNext();
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