import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/models/streaming_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreamingRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  StreamingRepository({required this.sharedPreferences, required this.dioClient});

  List<Streaming> streaming = [
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "il s'agit d'un concert de célébration", title: '20 ans gael', isEmission: true),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "il s'agit d'un concert de célébration", title: 'Célébration', isEmission: true),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "il s'agit d'un concert de célébration", title: 'cover'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "il s'agit d'un concert de célébration", title: 'sanjola 2023', isPodcast: true),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "il s'agit d'un concert de célébration", title: 'sanjola 2023', isPodcast: true),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: 'sanjola 2023'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: 'Esprit saint'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: '20 ans gael'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: '20 ans gael'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: '20 ans gael'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: '20 ans gael'),
    Streaming(cover: "", id: "", createdAt: DateTime.now(), description: "", title: '20 ans gael'),

  ];

  List<Streaming> getStreaming(){
    return streaming;
  }

}