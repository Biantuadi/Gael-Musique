class LoginModel{
  String email;
  String password;
  LoginModel({required , required this.email, required this.password});
  Map<String, dynamic> toJson({bool isForBd = false}){
  Map<String, dynamic> json = {};
  json["email"] = email;
  json["password"] = password;

  return json;
}

}