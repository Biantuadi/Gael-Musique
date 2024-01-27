class Album{
  late String id;
  late String title;
  late String subtitle;
  late String artist;
  late int year;
  late String? imgAlbum;
  late List<String> songs;
  late List<String> userBuy;
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

  Album.fromJson(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    subtitle = json["subtitle"];
    createdAt = DateTime.parse(json["created_at"]);
    imgAlbum = json["imgAlbum"];
    songs = json["songs"];
    userBuy = json["userBuy"];
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"] = title.toString();
    json["subtitle"] = subtitle;
    json["artist"] = artist;
    json["imgAlbum"] = imgAlbum;
    json["songs"] = songs;
    json["userBuy"] = userBuy;

    return json;
  }

}