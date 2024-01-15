class Song{
  late String id;
  late String title;
  late String artist;
  late String album;
  late double year;
  late DateTime createdAt;
  late String image;
  Song({
    required this.album,
    required this.title,
    required this.id,
    required this.artist,
    required this.createdAt,
    required this.year,
    required this.image
  });

  Song.fromJson(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    createdAt = DateTime.parse(json["created_at"]);
    artist = json["artist"];
    image = json["imgSong"];
    album = json["album"];
    year = json["year"];
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"] = title;
    json["created_at"] = createdAt.toString();
    json["artist"] = artist;
    json["imgSong"] = image;
    json["album"] = album;
    json["year"] = year;
    return json;
  }

}