import 'dart:math';

import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/image_asset_widget.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:wh_flutter_wave/flutter_wave.dart';

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
                          Text(provider.getSongDuration(), style: Theme.of(context).textTheme.titleSmall,),
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          FlutterWave(
                            volume: provider.audioPlayer.volume,
                            height: size.width / 4,
                            width: size.width,
                          ),
                          Slider(
                            min: 0,
                            max:provider.audioPlayer.duration !=  null ?provider.audioPlayer.duration!.inSeconds.toDouble() :0,
                            thumbColor: Colors.white,
                            inactiveColor: ThemeVariables.thirdColorBlack,
                            activeColor: Colors.white,
                            value: provider.audioPlayer.position.inSeconds.toDouble() != 0.0?((provider.audioPlayer.position.inSeconds.toDouble() -1)): provider.audioPlayer.position.inSeconds.toDouble() ,
                            onChanged: (double value) {
                              setState(() {
                                if(provider.audioPlayer.position.inSeconds.toDouble()  < provider.audioPlayer.duration!.inSeconds.toDouble()){
                                  provider.seekSong(position: Duration(seconds: value.toInt()));
                                }
                              });

                            },
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