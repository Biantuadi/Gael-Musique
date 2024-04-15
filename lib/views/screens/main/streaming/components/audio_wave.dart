import 'dart:math';
import 'package:Gael/utils/dimensions.dart';
import 'package:flutter/material.dart';

class StreamAudioWaves extends StatefulWidget{
  final double maxHeight;
  final bool songIsPlaying;
  const StreamAudioWaves({super.key, required this.maxHeight, required this.songIsPlaying,});
  @override
  StreamAudioWavesState createState()=>StreamAudioWavesState();

}
class StreamAudioWavesState extends State<StreamAudioWaves>{
  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [];
    Random random = Random();
    int maxRandomNum = widget.maxHeight.floor();
    int randomHeight = 0;
    for(int i=0; i<3; i++){
      if(maxRandomNum <= 2^32 && maxRandomNum <= pow(2, 32)){
        randomHeight = random.nextInt(maxRandomNum);
      }else{
        randomHeight = random.nextInt(200);
      }
      containers.add(
          AudioWaveContainer(
            maxHeight: widget.songIsPlaying? randomHeight.toDouble() : 1,
            songIsPlaying: widget.songIsPlaying,
          )
      );
      if(i==2){
        containers.add(SizedBox(width: Dimensions.spacingSizeExtraSmall/3,));
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.spacingSizeDefault/2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: containers,
      ),
    );
  }
}

class AudioWaveContainer extends StatefulWidget {
  final bool songIsPlaying;
  final double maxHeight;
  const AudioWaveContainer({Key? key,  required this.maxHeight, required this.songIsPlaying, }) : super(key: key);

  @override
  AudioWaveContainerState createState()=>AudioWaveContainerState();
}
class AudioWaveContainerState extends State<AudioWaveContainer>{
  @override
  Widget build(BuildContext context) {
    double height = widget.maxHeight;
    Random random = Random();
    int maxRandomNum = widget.maxHeight.floor();
    if(widget.songIsPlaying && maxRandomNum <= pow(2, 32) && maxRandomNum!=0 ){
      height = random.nextInt(maxRandomNum).toDouble();
    }
    if(height<0){
      height = height *-1;
    }
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      width: Dimensions.iconSizeExtraSmall,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
          color: Colors.white
      ),

    );
  }
}
