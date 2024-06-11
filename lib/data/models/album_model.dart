import 'package:Gael/data/models/song_model.dart';

class Album{
  late String id;
  late String title;
  late String subtitle;
  late String artist;
  late int year;
  late String? imgAlbum;
  late String? bdImgAlbum;
  late List<Song> songs;
  late List<dynamic> userBuy;
  late DateTime createdAt;
  Album({
    required this.title,
    required this.subtitle,
    required this.id,
    required this.userBuy,
    required this.songs,
    required this.createdAt,
    required this.year,
    required this.artist,
    required this.imgAlbum,
  });

  Album.fromJson({required Map<String, dynamic> json, bool isForDB = false}){
    id = json["_id"];
    title = json["title"];
    subtitle = json["subtitle"]??'';
    createdAt = DateTime.parse(json["createdAt"]);
    imgAlbum = json["imgAlbum"];
    bdImgAlbum = json["bdImgAlbum"];
    if(json["songs"] != null){
      songs = [];
      json["songs"].forEach((song){
        songs.add(Song.fromJson(song));
      });
    }
    userBuy = json["usersBuy"]??[];
    year = json["year"];
    artist = json["artist"];
  }

  Map<String , dynamic> toJson(){
    Map<String, dynamic> json = {};

    json["_id"] = id;
    json["title"] = title;
    json["subtitle"] = subtitle;
    json["createdAt"] = createdAt.toString();
    json["imgAlbum"] = imgAlbum;
    json["year"] = year;
    json["artist"] = artist;

    return json;
  }




}