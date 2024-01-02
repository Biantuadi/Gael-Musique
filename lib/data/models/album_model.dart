class Album{
  late String id;
  late String name;
  late String artist;
  late int year;
  late String image;
  late String genre;
  late List<String> songs;
  late List<String> userBuy;
  late DateTime createdAt;
  Album({
    required this.genre,
    required this.name,
    required this.id,
    required this.userBuy,
    required this.songs,
    required this.createdAt,
    required this.year,
    required this.artist,
    required this.image,
  });

  Album.fromJson(Map<String, dynamic> json){
    id = json["id"];
    artist = json["artist"];
    name = json["name"];
    createdAt = DateTime.parse(json["created_at"]);
    image = json["image"];
    songs = json["songs"];
    userBuy = json["userBuy"];
    genre = json["genre"];
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["artist"] = artist;
    json["name"] = name.toString();
    json["image"] = image;
    json["songs"] = songs;
    json["userBuy"] = userBuy;
    json["genre"] = genre;

    return json;
  }

}