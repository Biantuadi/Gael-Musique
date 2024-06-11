/*
import 'package:Gael/data/models/streaming_model.dart';

class Emission{
  late String id;
  late Streaming stream;
  Emission({
    required this.id
});
  Emission.fromJson(Map<String, dynamic> json){
    id = json["id"];
    stream = json["stream"];
    cover = json["cover"];
    createdAt = DateTime.parse(json["created_at"]);

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["stream"] = stream.toString();
    json["cover"] = cover;
    json["created_at"] = createdAt.toString();

    return json;
  }


}
 */