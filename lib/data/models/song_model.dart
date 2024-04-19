
class Song{
  late String id;
  late String title;
  late String album;
  late String songLink;
  late int year;
  late DateTime createdAt;
  late String? bdSongPath;
  late String image;
  Song({
    required this.album,
    required this.title,
    required this.id,
    ///required this.artist,
    required this.createdAt,
    required this.year,
    required this.image,
    this.bdSongPath,
  });

  Song.fromJson(Map<String, dynamic> json){
    id = json["_id"]??json["id"];
    title = json["title"];
    createdAt = DateTime.parse(json["createdAt"]);
    image = json["imgSong"]??"";
    album = json["album"]??json['album_id'];
    year = json["year"];
    songLink = json["songLink"];
    bdSongPath = json["bdSongPath"];

  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"] = title;
    json["createdAt"] = createdAt.toString();
    ///json["artist"] = artist;
    json["imgSong"] = image;
    json["album"] = album;
    json["year"] = year;
    json["songLink"] = songLink;
    json["bdSongPath"] = bdSongPath;
    return json;
  }

}