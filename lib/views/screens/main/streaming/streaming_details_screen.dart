import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'components/det_streaming_card.dart';
import 'components/video_button.dart';

class StreamingDetailsScreen extends StatefulWidget{
  const StreamingDetailsScreen({super.key, });
  @override
  StreamingDetailsScreenState createState()=>StreamingDetailsScreenState();
}
class StreamingDetailsScreenState extends State<StreamingDetailsScreen>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Consumer2<StreamingProvider, SongProvider>(builder: (context ,streamingProvider,songProvider, child){
      if(streamingProvider.streamingController.value.isPlaying && (songProvider.audioPlayer.playing || songProvider.songIsPlaying)){
        songProvider.pauseSong();
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeVariables.thirdColorBlack,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },icon: const Icon(Iconsax.arrow_left, color: Colors.white,),),
          title: Text(streamingProvider.currentStreaming!.title, style: Theme.of(context).textTheme.titleMedium,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              streamingProvider.streamingController.value.hasError == false?
              YoutubePlayer(
                controller: streamingProvider.streamingController,
                progressColors: const ProgressBarColors(
                  playedColor: ThemeVariables.primaryColor,
                ),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                ],
              ):
              Container(height: size.width/2, width: size.width, alignment: Alignment.center, child: Text("Une erreur s'est produite"),),
              SizedBox(height: Dimensions.spacingSizeSmall,),

              Container(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(streamingProvider.currentStreaming!.createdAt.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),),
                        Text(streamingProvider.currentStreaming!.title, style: Theme.of(context).textTheme.titleMedium,),
                        SizedBox(height: Dimensions.spacingSizeSmall,),
                      ],
                    ),
                    IconButton(
                        onPressed: (){

                        },
                        icon: const Icon(Iconsax.audio_square))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault),
                child: Wrap(
                  spacing: Dimensions.spacingSizeDefault,
                  children: const [
                    VideoButton(text: 'partager', icon: CupertinoIcons.share,),
                    VideoButton(text: 'liker', icon: CupertinoIcons.hand_thumbsup,),
                    VideoButton(text: 'soutenir', icon: CupertinoIcons.money_dollar,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(streamingProvider.currentStreaming!.description, style: Theme.of(context).textTheme.bodyMedium,),
                  Text(streamingProvider.currentStreaming!.date.toString(), style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),)
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal :Dimensions.spacingSizeDefault),
                child: Text("Suivez aussi...", style: Theme.of(context).textTheme.titleMedium,),
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.spacingSizeDefault),
                child: NetWorkImageWidget(imageUrl: streamingProvider.streamings[streamingProvider.randomIndex].cover, size: Size(size.width, size.width *.3),)
                ,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: streamingProvider.streamings.map((e) => DetStreamingCard(streaming: e, width: size.width/3,)).toList(),
                ),
              ),
              SizedBox(height: Dimensions.spacingSizeLarge,)
            ],
          ),
        ),
      );
    });
  }

}