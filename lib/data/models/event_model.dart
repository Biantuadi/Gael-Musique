class Event{
  late String id;
  late String title;
  late String image;
  late String bdCoverPath;
  late String location;
  late String description;
  late List<dynamic> tickets;
  late DateTime datetime;
  late DateTime createdAt;
  late String startTime;
  late String endTime;
  Event({
    required this.location,
    required this.title,
    required this.id,
    required this.tickets,
    required this.datetime,
    required this.image,
    required this.bdCoverPath,
    required this.createdAt,
    required this.description,
    required this.startTime,
    required this.endTime
  });

  Event.fromJson({required Map<String, dynamic> json, bool isForBD=false}){
    id = json["_id"];
    datetime = DateTime.parse(json["date"]);
    title = json["title"];
    createdAt = DateTime.parse(json["createdAt"]);
    image = json["img"];
    bdCoverPath = json["bdCover"]??"";
    tickets = json["tickets"]??[];
    startTime = json["startTime"]??"";
    endTime = json["endTime"]??"";
    location = json["location"];
    description = json["description"];
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["date"] = datetime;
    json["title"] = title;
    json["createdAt"] = createdAt.toString();
    json["img"] = image;
    json["tickets"] = tickets;
    json["time"] = startTime;
    json["location"] = location;
    json["description"] = description;
    return json;
  }

}