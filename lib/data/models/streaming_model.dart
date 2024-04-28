
import 'package:Gael/data/models/user_model.dart';

class Streaming{
  late String id;
  late String cover;
  late String title;
  late String bdCoverPath;
  late String description;
  late DateTime createdAt;
  late String videoLink;
  late DateTime date;

  Streaming({
    required this.cover,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.description,
    required this.videoLink,
    required this.bdCoverPath,
    required this.date
  });

  Streaming.fromJson(Map<String, dynamic> json){
    id = json["_id"]??"";
    title = json["title"];
    description = json["description"];
    cover = json["thumbnail"];
    bdCoverPath = json["bdCoverPath"]??"";
    videoLink = json["videoLink"];
    createdAt = DateTime.parse(json["createdAt"]);
    date = DateTime.parse(json["date"]);
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"] = title;
    json["description"] = description;
    json["cover"] = cover;
    json["bdCoverPath"] = bdCoverPath;
    json["createdAt"] = createdAt.toString();

    return json;
  }

  bool isFavorite({required User user}){
    if(user.favoriteStreaming != []){
        if(user.favoriteStreaming.contains(id)){
          return true;
        }
    }
    return false;
  }


}