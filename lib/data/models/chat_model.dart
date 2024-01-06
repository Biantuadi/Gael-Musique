import 'package:Gael/data/models/user_model.dart';

class Chat {
  late String id;
  late List<User> users;
  late DateTime createdAt;
  Chat({
    required this.id,
    required this.users,
    required this.createdAt,
  });

  Chat.fromJson(Map<String, dynamic> json){
    id = json["id"];
    json["users"].forEach((element){
      users.add(User.fromJson(element));
    });
    createdAt = DateTime.parse(json["created_at"]);

  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    List<Map<String, dynamic>> users_ = [];
    for(User user in users){
      users_.add(user.toJson());
    }
    json["users"] = users_;
    json["id"] = id;
    json["created_at"] = createdAt.toString();

    return json;
  }
 
}