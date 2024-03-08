import 'dart:math';

import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/repositories/streaming_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamingProvider with ChangeNotifier {
  StreamingRepository streamRepository;
  SocketProvider socketProvider;
  StreamingProvider({required this.streamRepository, required this.socketProvider});
  bool showStreamPlayContainer = false;

  List<Streaming> allStreaming = [];
  List<Streaming> streamings = [];
  List<Streaming>? streamingToShow;

  //STREAMING FILTERS
  bool? showEmission;
  bool? showSongs = true;
  bool? showPodCast;
  bool? showRadio;
  bool? showSanjola;
  Random random = Random();
  int randomIndex = 0;

  late YoutubePlayerController streamingController;
  Streaming? currentStreaming;

  setCurrentStreaming({required Streaming streaming, bool autoPlay=true}){
    currentStreaming = streaming;
    streamings = allStreaming.where((str) => str.id != currentStreaming!.id).toList();
    randomIndex = random.nextInt(streamings.length-1 );
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(streaming.videoLink)??"https://youtu.be/wlSJcbWwzds?si=MRPYEcfQO4A76Tcc";
    streamingController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          captionLanguage: 'fr',
          autoPlay: autoPlay
    ));
    streamingController.play();
    showStreamPlayContainer = true;
    notifyListeners();
  }
  playStreamVideo(){
    streamingController.play();
  }

  pauseStreamingVideo(){
    streamingController.pause();
  }
  disposePlayer(){
    streamingController.dispose();
    showStreamPlayContainer = false;
    notifyListeners();
  }
  getStreaming() async{
    //allStreaming = streamRepository.getStreaming();
    allStreaming = [];
    Response response = await streamRepository.getStreaming();

    if(response.statusCode == 200){
      List data = response.data["items"];
      print("LA DATA STRUCTURE STREAMING: ${response.data}");
      data.forEach((json) {
      allStreaming.add(Streaming.fromJson(json));
      });
    }
    streamingToShow = allStreaming;
  }

  setShowSongs() {
    showPodCast = null;
    showEmission = null;
    showRadio = null;
    showSongs = true;
    showSanjola = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowPodCasts() {
    showPodCast = true;
    showEmission = null;
    showRadio = null;
    showSongs = null;
    showSanjola = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowRadios() {
    showPodCast = null;
    showEmission = null;
    showRadio = true;
    showSongs = null;
    showSanjola = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowEmissions() {
    showPodCast = null;
    showEmission = true;
    showRadio = null;
    showSongs = null;
    showSanjola = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowSanjola() {
    showPodCast = null;
    showEmission = null;
    showRadio = null;
    showSongs = null;
    showSanjola = true;
    getFilteredStreamingToShow();
    notifyListeners();
  }



  getFilteredStreamingToShow() {
    streamingToShow = allStreaming
        .where((streaming) =>
            streaming.isRadio == showRadio &&
            streaming.isPodcast == showPodCast &&
            streaming.isEmission == showEmission)
        .toList();
  }
}
