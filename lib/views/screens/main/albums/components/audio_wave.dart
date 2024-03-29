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
      bool? isLast;
      bool? isFirst;
      if(i==0){
        isFirst = true;
      }
      if(i==99){
        isLast = true;
      }
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
            songIsPlaying: widget.songIsPlaying,
            isFirst: isFirst,
            isLast: isLast
          )
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
  final bool? isLast;
  final bool? isFirst;
  const AudioWaveContainer({Key? key, required this.screenWidth, required this.maxHeight, required this.isSelected, required this.songIsPlaying, this.isLast, this.isFirst,}) : super(key: key);

  @override
  AudioWaveContainerState createState()=>AudioWaveContainerState();
}
class AudioWaveContainerState extends State<AudioWaveContainer>{
  @override
  Widget build(BuildContext context) {
    double width = (widget.screenWidth / 100);
    double containerWidth = width - width * .05;
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
      margin: EdgeInsets.symmetric(horizontal: width * .02),
      height: height,
      decoration: BoxDecoration(
       /* border: widget.isSelected? null: Border(
          top: BorderSide(color: ThemeVariables.thirdColor.withOpacity(0.5), width: 1),
          bottom: BorderSide(color: ThemeVariables.thirdColor.withOpacity(0.5), width: 3),
          left: BorderSide(color: ThemeVariables.thirdColor.withOpacity(0.5), width: widget.isFirst == true? 1: 0.5),
          right: BorderSide(color: ThemeVariables.thirdColor.withOpacity(0.5), width: widget.isLast == true? 1: 0.5),
        ),*/
          color: widget.isSelected? ThemeVariables.primaryColor : ThemeVariables.thirdColor.withOpacity(0.7)
      ),

    );
  }
}
