// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';
import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/repositories/streaming_repository.dart';
import 'package:Gael/utils/get_formatted_duration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pod_player/pod_player.dart';
//import 'package:video_player/video_player.dart';

class StreamingProvider with ChangeNotifier {
  StreamingRepository streamRepository;

  StreamingProvider({required this.streamRepository,});
  bool showStreamPlayContainer = false;

  List<Streaming> allStreaming = [];
  List<Streaming> streamings = [];
  List<Streaming> streamingToShow = [];

  int streamingTotalItems = 0;
  int streamingCurrentPage = 0;
  int streamingTotalPages = 0;
  bool isLoadingData = false;

  setState(){
    notifyListeners();
  }

  Streaming? currentStreaming;
  //late VideoPlayerController videoPlayerController;
  late PodPlayerController podPlayerController;

  bool videoPlayerHasBeenInitialized = false;
  Duration videoDuration =  Duration.zero;
  Duration videoPosition =  Duration.zero;
  String videoDurationStr = "";
  String videoPositionStr = "";
  double videoPositionInDouble = 0;
  double videoDurationInDouble = 0;
  bool videoIsPlaying = false;

  incrementCurrentPage(){
    if(streamingCurrentPage < streamingTotalPages){
      streamingCurrentPage++;
      getStreaming();
    }
  }

  Random random = Random();
  int randomIndex = 0;

  playNext(){
    allStreaming = allStreaming ??[];
    if(currentStreaming != null){
      int indexOf = allStreaming!.indexOf(currentStreaming!);
      if(indexOf < allStreaming!.length - 2){
        currentStreaming = allStreaming![indexOf+1];
      }else if (indexOf == allStreaming!.length-1){
        currentStreaming = allStreaming![0];
      }
      setCurrentStreaming(streaming: currentStreaming!);
    }
  }

  playPost(){
    allStreaming = allStreaming??[];
    if(currentStreaming !=null){
      int indexOf = allStreaming!.indexOf(currentStreaming!);
      if(indexOf > 1){
        currentStreaming = allStreaming![indexOf-1];
      }else if (indexOf == 0){
        currentStreaming = allStreaming!.last;
      }
      setCurrentStreaming(streaming: currentStreaming!);
    }
  }

  String getallStreamingtrDuration(){
    videoDurationStr = getFormattedDuration(podPlayerController.totalVideoLength);
    return videoDurationStr;
  }
  String getallStreamingtrPosition(){
    videoPosition = podPlayerController.currentVideoPosition;
    videoPositionStr = getFormattedDuration(videoPosition);
    return videoPositionStr;
  }
  String getSongReminder(Duration duration, Duration position){
    return getFormattedDuration(duration - position);
  }
  getSongDuration()async{

  }
  getSongPosition()async{

  }
  setCurrentStreaming({required Streaming streaming, bool autoPlay=true})async{
    allStreaming = allStreaming?? [];
    randomIndex = 0;
    if(currentStreaming != streaming){
      currentStreaming = streaming;
      videoPlayerHasBeenInitialized = true;
      podPlayerController = PodPlayerController(
          playVideoFrom: PlayVideoFrom.youtube(streaming.videoLink),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          videoQualityPriority: [720, 360, ]
        )
      )..initialise().then((value){
        podPlayerController.play();
      });
      notifyListeners();

      if(currentStreaming != null){
        streamings = allStreaming!.where((str) => str.id != currentStreaming!.id).toList();
        randomIndex = random.nextInt(streamings.length-1 );
      }
    }
    showStreamPlayContainer = true;
    notifyListeners();
  }
  playVideo(){
    podPlayerController.play();
    notifyListeners();
  }

  pauseVideo(){
    podPlayerController.pause();
    notifyListeners();
  }
  disposePlayer(){
    podPlayerController.dispose();
    showStreamPlayContainer = false;
    currentStreaming = null;
    notifyListeners();
  }


  getStreaming() async{
    allStreaming = [];
    if(streamingCurrentPage>0){
      isLoadingData = true;
      notifyListeners();
    }
    Response response = await streamRepository.getStreaming(
        page: streamingCurrentPage>0? streamingCurrentPage:null
    );

    if(response.statusCode == 200){
      List data = response.data["items"];
      streamingTotalItems = response.data["totalItems"];
      streamingCurrentPage = response.data["currentPage"];
      streamingTotalPages = response.data["totalPages"];
      allStreaming = allStreaming??[];
      data.forEach((json) {
       allStreaming!.add(Streaming.fromJson(json));
      });
    }
    if(streamingCurrentPage>0){
      isLoadingData = false;
      notifyListeners();
    }
    isLoadingData = false;
    notifyListeners();
    streamingToShow = allStreaming;
  }




}
