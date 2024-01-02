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
  late String role;
  late Map<String, dynamic> preferences;
  late DateTime createdAt;
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
    required this.role
});

  User.fromJson(Map<String, dynamic> json){
    id = json["id"];
    lastName = json["lastName"];
    firstName = json["firstName"];
    createdAt = DateTime.parse(json["created_at"]);
    role = json["role"];
    profileImage = json["profileImage"];
    preferences = json["preferences"];
    birthDay = DateTime.parse(json["birthDay"]);
    bio = json["bio"];
    address = json["address"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson({bool isForBd = false}){
    Map<String, dynamic> json = {};
    json["id"] = id;
    json["lastName"] = lastName;
    json["firstName"] = firstName.toString();
    json["role"] = role;
    json["profileImage"] = profileImage;
    json["preferences"] = preferences;
    json["birthDay"] = birthDay.toString();
    json["bio"] = bio;
    json["address"] = address;
    json["phone"] = phone;

    return json;
  }

}