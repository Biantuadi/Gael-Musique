class NotificationModel{
  late String id;
  late String title;
  late String message;
  late String? imgUrl;
  late DateTime dateTime;
  late bool read;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.imgUrl,
    required this.dateTime,
    required this.read,
});
  NotificationModel.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    title = json["title"];
    dateTime = DateTime.parse(json["created_at"]);
    message = json["message"];
    imgUrl = json["image"];
    read = json["read"];

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["title"]=title;
    json["created_at"] = dateTime.toString();
    json["message"] = message;
    json["image"] = imgUrl;

    return json;
  }

}