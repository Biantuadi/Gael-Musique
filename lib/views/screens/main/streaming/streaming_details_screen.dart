import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
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
      if(streamingProvider.videoPlayerController.value.isPlaying && (songProvider.audioPlayer.playing || songProvider.songIsPlaying)){
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
              streamingProvider.videoPlayerController.value.hasError == false?
              AspectRatio(
                aspectRatio: streamingProvider.videoPlayerController.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(streamingProvider.videoPlayerController),
                    _ControlsOverlay(controller: streamingProvider.videoPlayerController),
                    VideoProgressIndicator(streamingProvider.videoPlayerController, allowScrubbing: true),
                  ],
                ),
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
class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
