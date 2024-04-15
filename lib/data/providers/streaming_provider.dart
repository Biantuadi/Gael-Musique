import 'dart:math';
import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/repositories/streaming_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamingProvider with ChangeNotifier {
  StreamingRepository streamRepository;

  StreamingProvider({required this.streamRepository,});
  bool showStreamPlayContainer = false;

  List<Streaming> allStreaming = [];
  List<Streaming> streamings = [];
  List<Streaming>? streamingToShow;

  int streamingTotalItems = 0;
  int streamingCurrentPage = 0;
  int streamingTotalPages = 0;
  bool isLoadingData = false;


  incrementCurrentPage(){
    if(streamingCurrentPage < streamingTotalPages){
      streamingCurrentPage++;
      getStreaming();
    }
  }

  //STREAMING FILTERS
  bool? showEmission;
  bool? showSongs = true;
  bool? showPodCast;
  bool? showStreaming;
  bool? showRadio;
  bool? showAll;

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
      data.forEach((json) {
       allStreaming.add(Streaming.fromJson(json));
      });
    }
    if(streamingCurrentPage>0){
      isLoadingData = false;
      notifyListeners();
    }
    streamingToShow = allStreaming;
  }

  setShowSongs() {
    showPodCast = null;
    showEmission = null;
    showRadio = null;
    showSongs = true;
    showAll = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowPodCasts() {
    showPodCast = true;
    showEmission = null;
    showRadio = null;
    showSongs = null;
    showAll = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowRadios() {
    showPodCast = null;
    showEmission = null;
    showRadio = true;
    showSongs = null;
    showAll = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowEmissions() {
    showPodCast = null;
    showEmission = true;
    showRadio = null;
    showSongs = null;
    showAll = null;
    getFilteredStreamingToShow();
    notifyListeners();
  }

  setShowAll() {
    showPodCast = null;
    showEmission = null;
    showRadio = null;
    showSongs = null;
    showAll = true;
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
