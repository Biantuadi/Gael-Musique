class FactureAlbum{
  late String id;
  late String albumId;
  late String userId;
  late double price;
  late DateTime createdAt;
  FactureAlbum({
    required this.albumId,
    required this.id,
    required this.createdAt,
    required this.price,
    required this.userId,
  });

  FactureAlbum.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    userId = json["user"];
    albumId = json["album"];
    createdAt = DateTime.parse(json["created_at"]);
    price = json["price"];

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["artist"] = userId;
    json["album"] = albumId.toString();
    json["created_at"] = createdAt.toString();
    json["price"] = price;

    return json;
  }

}