class Event{
  late String id;
  late String title;
  late String image;
  late String location;
  late String description;
  late List<String> tickets;
  late DateTime datetime;
  late DateTime createdAt;
  late String time;
  Event({
    required this.location,
    required this.title,
    required this.id,
    required this.tickets,
    required this.datetime,
    required this.image,
    required this.createdAt,
    required this.description,
    required this.time
  });

  Event.fromJson(Map<String, dynamic> json){
    id = json["id"];
    datetime = json["date"];
    title = json["title"];
    createdAt = DateTime.parse(json["createdAt"]);
    image = json["image"];
    tickets = json["tickets"];
    time = json["time"];
    location = json["genre"];
    description = json["description"];
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["date"] = datetime;
    json["title"] = title;
    json["created_at"] = createdAt.toString();
    json["image"] = image;
    json["tickets"] = tickets;
    json["time"] = time;
    json["genre"] = location;
    json["description"] = description;
    return json;
  }

}