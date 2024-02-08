import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/user_model.dart';

class Message{
  late String id;
  late String content;
  late DateTime sentAt;
  late bool read;
  late User recipent;
  late Chat chat;
  late User expediteur;

  Message({
    required this.content,
    required this.sentAt,
    required this.read,
    required this.recipent,
    required this.expediteur,
    required this.chat
  });

  Message.fromJson(Map<String, dynamic> json){
    id = json["id"];
    content = json["content"];
    chat = Chat.fromJson(json["chat"]);
    sentAt = DateTime.parse(json["created_at"]);
    read = json["read"];
    recipent = User.fromJson(json["recipent"]);
    expediteur = User.fromJson(json["expediteur"]);

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["content"] = content;
    json["chat_id"] = chat.id;
    json["created_at"] = sentAt.toString();
    json["read"] = read;
    json["recipent"] = recipent.toJson();
    json["expediteur"] = expediteur.toJson();

    return json;
  }

}