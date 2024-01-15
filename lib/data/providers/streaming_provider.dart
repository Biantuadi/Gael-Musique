import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/repositories/streaming_repository.dart';
import 'package:flutter/foundation.dart';



class StreamingProvider with ChangeNotifier{
  StreamingRepository streamRepository;
  StreamingProvider({required this.streamRepository});

  List<Streaming> allStreaming = [];
  List<Streaming>? streamingToShow;

  //STREAMING FILTERS
  bool? showEmission;
  bool? showSongs;
  bool? showPodCast;
  bool? showRadio;
  bool showAll = true;

  getStreaming(){
    allStreaming = streamRepository.getStreaming();
    streamingToShow = allStreaming;
  }
  getSongs(){
    //allStreaming = streamRepository.getStreaming();
    //streamingToShow = allStreaming;
  }

  setShowPodCasts(){
    showPodCast = true;
    showEmission = null;
    showRadio = null;
    showAll = false;
    getFilteredStreamingToShow();
    notifyListeners();
  }
  setShowRadios(){
    showPodCast = null;
    showEmission = null;
    showRadio = true;
    showAll = false;
    getFilteredStreamingToShow();
    notifyListeners();
  }
  setShowEmissions(){
    showPodCast = null;
    showEmission = true;
    showRadio = null;
    showAll = false;
    getFilteredStreamingToShow();
    notifyListeners();
  }
  getAllStreamingToShow(){
    showPodCast = null;
    showEmission = null;
    showRadio = null;
    showAll = true;
    streamingToShow = allStreaming;
    notifyListeners();
  }
  getFilteredStreamingToShow(){
    streamingToShow = allStreaming.where(
            (streaming) =>
            streaming.isRadio == showRadio &&
            streaming.isPodcast == showPodCast &&
            streaming.isEmission == showEmission
    ).toList();
  }

}