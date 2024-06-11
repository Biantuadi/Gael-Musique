import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/models/user_model.dart';

class EventTicket{
  late String id;
  late Event event;
  late User user;
  late double price;
  late DateTime createdAt;
  EventTicket({
    required this.event,
    required this.id,
    required this.createdAt,
    required this.price,
    required this.user,
  });

  EventTicket.fromJson({required Map<String, dynamic> json, bool isForDB = false}){
    id = json["_id"];
    user = User.fromJson(json["user"]);
    event = Event.fromJson(json: json["event"]);
    createdAt = DateTime.parse(json["createdAt"]);
    price = json["price"];

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["userId"] = user.id;
    json["event"] = user.toString();
    json["createdAt"] = createdAt.toString();
    json["price"] = price;

    return json;
  }

}