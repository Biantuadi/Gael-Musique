import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/models/streaming_model.dart';

class SongAndStreamRelated{
  Song? song;
  Streaming? streaming;
  bool isValid;

  SongAndStreamRelated({required this.isValid, this.streaming, this.song});

  bool songIsNotNull(){
    return song != null;
  }
  bool streamIsNotNull(){
    return streaming != null;
  }
  DateTime? getCreatedDate(){
    isValid = songIsNotNull() || streamIsNotNull();
    if(isValid){
      if(song != null){
          return song!.createdAt;
      }
      return streaming!.createdAt;
    }
    return null;
  }
}
