import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/custom_snackbar.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'audio_wave.dart';

class StreamSongWidget extends StatefulWidget{
  final Song song;
  final Size size;
  final SongProvider provider;
  const StreamSongWidget({super.key, required this.song, required this.provider, required this.size});

  @override
  State<StatefulWidget> createState() {
    return StreamSongWidgetState();
  }

}

class StreamSongWidgetState extends State<StreamSongWidget>{

  bool thisSongIsPlaying = false;
  bool thisIsCurrentSong = false;

  @override
  void initState() {
    super.initState();
    if(widget.provider.currentSong == widget.song){
      thisIsCurrentSong = true;

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = widget.size;
    String albumCover = widget.provider.getAlbumCoverUrl(widget.song.album);
      return GestureDetector(
        onTap: (){
          if(widget.provider.thisSongIsCurrent(widget.song) == false){
            widget.provider.setCurrentSong(song: widget.song, onError: (err){
              ScaffoldMessenger.of(context).showSnackBar(
                customSnack(text: err??"Une erreur s'est produite", context: context, bgColor: Colors.red)
              );
            });
          }
          if(!widget.provider.audioPlayer.playing || !widget.provider.songIsPlaying){
            Provider.of<SongProvider>(context, listen: false).playSong();
          }
          Navigator.of(context).pushNamed(Routes.songDetailsScreen);
        },
        child: Stack(
          children: [
            NetWorkImageWidget(size: Size(size.width, size.width), imageUrl: albumCover, radius: Dimensions.radiusSizeDefault,),
            Opacity(
              opacity: .5,
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
                ),

              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.spacingSizeSmall),
              margin: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault, vertical: Dimensions.spacingSizeSmall/2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSizeDefault),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.song.title, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
                  SizedBox(height: Dimensions.spacingSizeSmall/3,),
                  Text('${widget.song.year}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
                  SizedBox(height: Dimensions.spacingSizeSmall/3,),
                  ((widget.provider.songIsPlaying || widget.provider.audioPlayer.playing) && thisIsCurrentSong)?
                  Text(widget.provider.getSongStrPosition(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),):
                      const SizedBox()
                ],
              ),
            ),
            Positioned(
              bottom: Dimensions.spacingSizeSmall,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      if(((widget.provider.songIsPlaying || widget.provider.audioPlayer.playing) && thisIsCurrentSong)){
                        widget.provider.pauseSong();
                      }else{
                        widget.provider.playSong();
                      }
                    }, icon: Icon(((widget.provider.songIsPlaying || widget.provider.audioPlayer.playing) && thisIsCurrentSong)? CupertinoIcons.pause_fill : CupertinoIcons.play_fill, size: Dimensions.iconSizeSmall, color: Colors.white,)),
                    StreamAudioWaves(maxHeight: Dimensions.iconSizeDefault, songIsPlaying: ((widget.provider.songIsPlaying || widget.provider.audioPlayer.playing) && thisIsCurrentSong),),
                  ],
                )
            )
          ],
        ),
      );
      
  }
}