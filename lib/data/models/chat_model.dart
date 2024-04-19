import 'package:Gael/data/models/user_model.dart';

import 'message_model.dart';

class Chat {
  late String id;
  late User user1;
  late User user2;
  late DateTime createdAt;
  late List<Message> messages;
  Chat({
    required this.id,
    required this.user1,
    required this.user2,
    required this.createdAt,
    this.messages = const [],
  });

  Chat.fromJson({required Map<String, dynamic> json, bool isForBD = false}){
    id = json["_id"]??json['id'];
    user1 =  User.fromJson(json["user1"]);
    user2 =  User.fromJson(json["user2"]);
    createdAt = DateTime.parse(json["created_at"]);
    messages = messages.isNotEmpty? messages : [];
    if(json["message"] != null){
      json["message"].forEach(
              (message){
            messages.add(Message.fromJson(json :message));
          }
      );
    }
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
     json["id"] = id;
     json["user1_id"] = user1.id;
     json["user2_id"] = user2.id;
     json["created_at"] = createdAt.toString();
      //json["messages"] = createdAt.toString();

    return json;
  }

}