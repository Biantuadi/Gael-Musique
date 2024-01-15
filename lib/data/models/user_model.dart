import 'package:Gael/data/models/preference_model.dart';

class User{
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String profileImage;
  late String phone;
  late DateTime birthDay;
  late String bio;
  late String address;
  late String? role;
  late Preference preferences;
  late DateTime createdAt;
  late bool? isConected;
  late List<String>? eventInterest;
  User({
    required this.phone,
    required this.firstName,
    required this.id,
    required this.address,
    required this.bio,
    required this.birthDay,
    required this.createdAt,
    required this.email,
    required this.lastName,
    required this.preferences,
    required this.profileImage,
     this.role,
    this.isConected,
    this.eventInterest

});

  User.fromJson(Map<String, dynamic> json){
    id = json["id"];
    lastName = json["lastName"];
    firstName = json["firstName"];
    createdAt = DateTime.parse(json["created_at"]);
    role = json["role"];
    profileImage = json["profileImage"];
    preferences =Preference.fromJson(json["preferences"]);
    birthDay = DateTime.parse(json["birthDay"]);
    bio = json["bio"];
    address = json["address"];
    phone = json["phone"];
    role = json["role"];
    isConected = json["isConected"];
    eventInterest = json["eventInterest"];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["lastName"] = lastName;
    json["firstName"] = firstName.toString();
    json["role"] = role;
    json["profileImage"] = profileImage;
    json["preferences"] = preferences.toJson();
    json["birthDay"] = birthDay.toString();
    json["bio"] = bio;
    json["address"] = address;
    json["phone"] = phone;
    json["role"] = role;
    json["isConected"] = isConected;
    json["eventInterest"] = eventInterest;

    return json;
  }

}