import 'package:Gael/data/models/preference_model.dart';

class User{
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String profileImage;
  late String phone;
  late String bio;
  late String bdAvatarPath;
  late String? role;
  late Preference preferences;
  late DateTime createdAt;
  late bool? isConected;
  late List<String>? eventInterest;
  User({
    required this.phone,
    required this.firstName,
    required this.id,
    required this.bio,
    required this.createdAt,
    required this.email,
    required this.lastName,
    required this.preferences,
    required this.profileImage,
     this.bdAvatarPath = "",
     this.role,
    this.isConected,
    this.eventInterest

});

  User.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    lastName = json["lastname"];
    firstName = json["firstname"];
    createdAt = DateTime.parse(json["createdAt"]);
    profileImage = json["avatar"]??"";
    preferences =Preference.fromJson(json["preferences"]);
    bio = json["bio"]??"";
    phone = json["phone"]??"";
    role = json["role"];
    bdAvatarPath = json["bdAvatarPath"];
    isConected = json["isConected"]??false;
    eventInterest = json["eventInterest"] ?? [];
    email = json["email"];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    json["lastName"] = lastName;
    json["firstName"] = firstName.toString();
    json["role"] = role;
    json["avatar"] = profileImage;
    json["preferences"] = preferences.toJson();
    json["bio"] = bio;
    json["bdAvatarPath"] = bdAvatarPath;
    json["phone"] = phone;
    json["role"] = role;
    json["isConected"] = isConected;
    json["eventInterest"] = eventInterest;

    return json;
  }

}