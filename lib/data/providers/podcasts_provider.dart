import 'package:Gael/data/models/podcast_model.dart';
import 'package:Gael/data/models/podcast_model.dart';
import 'package:Gael/data/repositories/podcast_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PodcastsProvider with ChangeNotifier{
  PodCastsRepository podcastsRepository;
  PodcastsProvider({required this.podcastsRepository});

  List<Podcast>? podcasts;
  int podcastTotalItems =0;
  int podcastCurrentPage =0;
  int podcastTotalPages =0;

  bool isLoadingData = false;
  incrementCurrentPage(){
    if(podcastCurrentPage < podcastTotalPages){
      podcastCurrentPage++;
      getPodcastsFromAPi();
    }
  }
  Future getPodcastsFromAPi()async{
    Response response = await podcastsRepository.gePodcasts();
    if(response.statusCode == 200){
      List data = response.data["items"];
      podcasts = podcasts??[];
      podcastTotalItems = response.data["totalItems"];
      podcastCurrentPage = response.data["currentPage"];
      podcastTotalPages = response.data["totalPages"];
      data.forEach((podcast)async {
        podcasts!.add(podcast.fromJson(json : podcast));
        notifyListeners();
      });
    }
  }



}