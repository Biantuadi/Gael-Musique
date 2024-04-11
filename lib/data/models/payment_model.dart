class NotificationModel{
  late String id;
  late String title;
  late String message;
  late DateTime dateTime;
  late bool read;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.read,
  });
  NotificationModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    dateTime = DateTime.parse(json["created_at"]);
    message = json["message"];
    read = json["read"];

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["title"]=title;
    json["created_at"] = dateTime.toString();
    json["message"] = message;

    return json;
  }

}