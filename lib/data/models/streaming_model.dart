
import 'package:Gael/data/models/user_model.dart';

class Streaming{
  late String id;
  late String cover;
  late String title;
  late String description;
  late DateTime createdAt;
  late bool? isEmission;
  late bool? isPodcast;
  late bool? isRadio;

  Streaming({
    required this.cover,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.description,
    this.isEmission,
    this.isPodcast,
    this.isRadio
  });

  Streaming.fromJson(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    description = json["description"];
    cover = json["cover"];
    isEmission = json["is_emission"];
    isPodcast = json["is_podcast"];
    isRadio = json["is_radio"];
    createdAt = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"] = title;
    json["description"] = description;
    json["cover"] = cover;
    json["is_emission"] = isEmission;
    json["is_podcast"] = isPodcast;
    json["is_radio"] = isRadio;
    json["created_at"] = createdAt.toString();

    return json;
  }

  bool isFavorite({required User user}){
    //if(user.preferences.containsKey("streaming")){
      //if(user.preferences["streaming"].contains(toJson())){
        //return true;
      //}
    //}
    return false;
  }


}