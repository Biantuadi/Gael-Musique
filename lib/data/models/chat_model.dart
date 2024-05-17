import 'package:Gael/data/data_base/database_client.dart';
import 'package:Gael/data/models/user_model.dart';

import 'message_model.dart';

class Chat {
  late String id;
  late String user1Id;
  late String user2Id;
  late DateTime? createdAt;
  late DateTime updatedAt;
  late List<Message> messages;
  late User? user1;
  late User? user2;

  Chat({
    required this.id,
    required this.user1Id,
    required this.user2Id,
     this.user1 = null,
    this.user2 = null,
    this.createdAt,
    required this.updatedAt,
    this.messages = const [],
  });

  Chat.fromJson({required Map<String, dynamic> json, bool isForBD = false}){
    id = json["_id"]??json['id'];
    user1Id =  json["user1"];
    user2Id =  json["user2"];
    createdAt = DateTime.parse(json["createdAt"]);
    updatedAt = DateTime.tryParse(json["updatedAt"]??"") ?? DateTime.now();

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
     json["_id"] = id;
     json["user1"] = user1Id;
     json["user2"] = user2Id;
     json["createdAt"] = createdAt.toString();
     json["updatedAt"] = createdAt.toString();
      //json["messages"] = createdAt.toString();

    return json;
  }

}