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
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      NetWorkImageWidget(size: Size(size.width * 0.6, size.width *0.8), imageUrl: provider.currentAlbum!.imgAlbum??'', radius: Dimensions.radiusSizeDefault,),
                      SizedBox(height: Dimensions.spacingSizeSmall,),
                      Text(provider.currentAlbum!.artist, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
                      Text(provider.currentSong!.title, style: Theme.of(context).textTheme.titleSmall,),
                      Container(
                        padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(provider.getSongStrDuration(), style: Theme.of(context).textTheme.titleSmall,),
                            Text("-${provider.getSongReminder(provider.audioPlayer.duration ?? Duration.zero , provider.audioPlayer.position)}", style: Theme.of(context).textTheme.titleSmall,),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.spacingSizeSmall,),
                      Container(
                        width: size.width,
                        height: size.width / 4,
                        alignment: Alignment.center,
                        color: ThemeVariables.thirdColorBlack,
                        child: provider.isLoading? const CircularProgressIndicator(
                          strokeWidth: 4,
                          color: ThemeVariables.primaryColor,
                        ): Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            AudioWaves(
                              screenWidth: size.width,
                              maxHeight: size.width/4 - 2* Dimensions.spacingSizeDefault,
                              songIsPlaying: provider.audioPlayer.playing,
                              songPosition:provider.songPosition.inSeconds.toDouble() != 0.0?((provider.songPosition.inSeconds.toDouble()-1)): provider.songPositionInDouble,
                              totalDuration: provider.audioPlayer.duration!.inSeconds.toDouble(),
                            ),
                            Container(
                              //alignment: Alignment.bottomCenter,
                              child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: size.width / 4,
                                    trackShape: const RectangularSliderTrackShape(),
                                    thumbShape: const RoundSliderThumbShape(),
                                    activeTrackColor: Colors.orangeAccent.withOpacity(0.5),
                                    thumbColor: Colors.orangeAccent.withOpacity(0.5),
                                    inactiveTrackColor: Colors.blue.withOpacity(0.5),

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
                                          print("POSITION: ${provider.songPosition.inSeconds.toDouble()}");
                                          print("DURATION: ${provider.songDuration.inSeconds.toDouble()}");
                                          if(provider.songPosition.inSeconds.toDouble() < provider.songDuration.inSeconds.toDouble()){
                                            provider.audioPlayer.seek(Duration(seconds: value.toInt()));
                                          }
                                        });

                                      },
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
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