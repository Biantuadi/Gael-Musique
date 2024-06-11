import 'package:Gael/data/models/podcast_model.dart';
import 'package:Gael/data/models/radio_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/models/streaming_model.dart';

class DiscoverModelsRelated{
  Song? song;
  Streaming? streaming;
  Podcast? podcast;
  RadioModel? radio;

  DiscoverModelsRelated({
    this.streaming,
    this.song,
    this.podcast,
    this.radio});

  bool songIsNotNull(){
    return song != null;
  }
  bool streamIsNotNull(){
    return streaming != null;
  }
  bool radioIsNotNull(){
    return radio != null;
  }
  bool podcastIsNotNull(){
    return podcast != null;
  }
  bool isValid(){
    if(
    radioIsNotNull() && (podcast == null && song ==null && streaming == null) ||
        songIsNotNull() && (podcast == null && radio ==null && streaming == null) ||
        podcastIsNotNull() && (radio == null && song ==null && streaming == null) ||
        streamIsNotNull() && (radio == null && song ==null && podcast == null)
    ){
      return true;
    }
    return false;
  }
  DateTime? getCreatedDate(){
    if(isValid()){
      if(song != null){
          return song!.createdAt;
      }
      if(podcast != null){
        return podcast!.createdAt;
      }
      if(radio != null ){
          return radio!.createdAt;
      }
      return streaming!.createdAt;
    }
    return null;
  }
}
