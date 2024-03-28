import 'dart:math';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class AudioWaves extends StatefulWidget{
  final double screenWidth;
  final double maxHeight;
  final bool songIsPlaying;
  final double songPosition;
  final double totalDuration;

  const AudioWaves({super.key, required this.screenWidth, required this.maxHeight, required this.songIsPlaying, required this.songPosition, required this.totalDuration});
  @override
  AudioWavesState createState()=>AudioWavesState();

}
class AudioWavesState extends State<AudioWaves>{
  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [];
    double position = (widget.songPosition * 100)/widget.totalDuration;
    Random random = Random();
    int maxRandomNum = widget.maxHeight.floor();
    int randomHeight = 0;
    for(int i=0; i<100; i++){
      bool childIsSelected = i<=position;
      if(maxRandomNum <= 2^32 && maxRandomNum <= pow(2, 32)){
        randomHeight = random.nextInt(maxRandomNum);
      }else{
        randomHeight = random.nextInt(200);
      }
      containers.add(
          AudioWaveContainer(
            screenWidth: widget.screenWidth,
            maxHeight: widget.songIsPlaying? randomHeight.toDouble() : 1,
            isSelected: childIsSelected,
            songIsPlaying: widget.songIsPlaying
            ,)
      );
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
  final double screenWidth;
  final double maxHeight;
  final bool isSelected;
  final bool songIsPlaying;
  const AudioWaveContainer({Key? key, required this.screenWidth, required this.maxHeight, required this.isSelected, required this.songIsPlaying,}) : super(key: key);

  @override
  AudioWaveContainerState createState()=>AudioWaveContainerState();
}
class AudioWaveContainerState extends State<AudioWaveContainer>{
  @override
  Widget build(BuildContext context) {
    double width = (widget.screenWidth / 100);
    double containerWidth = width - width * .01;
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
      width: containerWidth,
      height: height,
      decoration: BoxDecoration(
          border: widget.isSelected? null: Border.all(width: 1, color: ThemeVariables.iconInactive),
          color: widget.isSelected? ThemeVariables.primaryColor : Colors.transparent
      ),

    );
  }
}
