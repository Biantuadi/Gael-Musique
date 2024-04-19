import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/user_model.dart';

class Message{
  late String id;
  late String content;
  late DateTime sentAt;
  late bool read;
  late User user;
    late String chatId;

  Message({
    required this.content,
    required this.sentAt,
    required this.read,
    required this.user,
    required this.id,
    required chatId

  });

  Message.fromJson({required Map<String, dynamic> json, bool isForBD = false}){
    id = json["_id"];
    chatId = json["chat_id"];
    content = json["content"];
    sentAt = DateTime.parse(json["created_at"]);
    if(isForBD){
      read =json["read"] == 1? true: false;
    }else{
      read = json["read"];
    }
    user = User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["content"] = content;
    json["created_at"] = sentAt.toString();
    json["read"] = read;
    json["user_id"] = user.id;
    json["chat_id"] = chatId;

    return json;
  }

}