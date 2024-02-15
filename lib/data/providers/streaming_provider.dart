import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/repositories/streaming_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class StreamingProvider with ChangeNotifier {
  StreamingRepository streamRepository;
  StreamingProvider({required this.streamRepository});

  List<Streaming> allStreaming = [];
  List<Streaming>? streamingToShow;

  //STREAMING FILTERS
  bool? showEmission;
  bool? showSongs = true;
  bool? showPodCast;
  bool? showRadio;
  bool? showSanjola;

  getStreaming() async{
    //allStreaming = streamRepository.getStreaming();
    allStreaming = [];
    Response response = await streamRepository.getStreaming();

    if(response.statusCode == 200){
      List data = response.data["items"];
      print("LA DATA STRUCTURE: ${response.data}");
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
