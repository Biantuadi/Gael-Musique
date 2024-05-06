import 'package:Gael/data/models/preference_model.dart';

import 'app/image_util_model.dart';

class User{
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String profileImage;
  late String phone;
  late String bio;
  late String? bdAvatarPath;
  late String? role;
  late Preference preferences;
  late DateTime createdAt;
  late bool? isConected;
  late List<String>? eventInterest;
  late List<String> favoriteStreaming;
  late List<String> favoriteSongs;
  late List<String> favoriteRadios;
  late List<String> favoritePodcasts;
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
    this.favoriteSongs = const [],
    this.favoriteStreaming = const [],
    this.favoritePodcasts = const [],
    this.favoriteRadios = const [],
     this.bdAvatarPath,
     this.role,
    this.isConected,
    this.eventInterest

});

  User.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    lastName = json["lastname"]??'';
    firstName = json["firstname"]??"";
    createdAt = DateTime.parse(json["createdAt"]);
    profileImage = json["avatar"]??"";
    preferences =Preference.fromJson(json["preferences"]);
    bio = json["bio"]??"";
    phone = json["phone"]??"";
    role = json["role"];
    bdAvatarPath = json["bdAvatarPath"];
    isConected = json["isConected"]??false;
    eventInterest = json["eventInterest"] ?? [];
    favoriteStreaming = json["favoriteStreaming"] ?? [];
    favoritePodcasts = json["favoritePodcasts"] ?? [];
    favoriteRadios = json["favoriteRadios"] ?? [];
    favoriteSongs = json["favoriteSongs"] ?? [];
    email = json["email"];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["_id"] = id.toString();
    json["lastName"] = lastName.toString();
    json["firstName"] = firstName.toString();
    json["role"] = role.toString();
    json["avatar"] = profileImage.toString();
    //json["preferences"] = preferences.toJson();
    json["bio"] = bio;
    json["bdAvatarPath"] = bdAvatarPath.toString();
    json["email"] = email.toString();
    json["role"] = role.toString();
    json["createdAt"] = createdAt.toString();
   // json["eventInterest"] = eventInterest;
 //   json["favoriteStreaming"] = favoriteStreaming;
   // json["favoriteSongs"] = favoriteSongs;

    return json;
  }

  ImageUtilMap imageCover(){
    if(bdAvatarPath != "" || bdAvatarPath != null){
      return ImageUtilMap(imagePath: bdAvatarPath!, isFromInternet: false);
    }
    return ImageUtilMap(imagePath: profileImage, isFromInternet: true);
  }


}