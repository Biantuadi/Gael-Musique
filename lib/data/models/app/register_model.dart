import 'dart:io';

class RegisterModel{
  late String? email;
  late String? firstName;
  late String? lastName;
  late String? phone;
  late File? avatar;
  late String? password;

  RegisterModel({
  this.firstName,
  this.lastName,
  this.email,
  this.password,
  this.phone,
  this.avatar
  });
Map<String, dynamic> toJson(){
  Map<String, dynamic> json = {};
  json["email"] = email;
  json["password"] = password;
  json["phone"] = phone;
  json["firstname"] = firstName;
  json["lastname"] = lastName;

  return json;
}
  RegisterModel.fromJson(Map<String, dynamic> json){
    email = json["email"];
    password = json["password"];
    phone = json["phone"];
    firstName = json["firstname"];
    lastName = json["lastname"];
  }

}