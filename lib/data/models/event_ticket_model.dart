class EventTicket{
  late String id;
  late String eventId;
  late String userId;
  late double price;
  late DateTime createdAt;
  EventTicket({
    required this.eventId,
    required this.id,
    required this.createdAt,
    required this.price,
    required this.userId,
  });

  EventTicket.fromJson(Map<String, dynamic> json){
    id = json["id"];
    userId = json["user"];
    eventId = json["event"];
    createdAt = DateTime.parse(json["created_at"]);
    price = json["price"];

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["artist"] = userId;
    json["event"] = eventId.toString();
    json["created_at"] = createdAt.toString();
    json["price"] = price;

    return json;
  }

}