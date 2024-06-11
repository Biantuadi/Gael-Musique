class UserUpdate{
  late String? id;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? phone;
  late String? password;
  late String? bio;
  late String? role;

  UserUpdate({
     this.phone,
     this.firstName,
     this.id,  this.bio,
    this.email,
     this.lastName,
    this.role,
    this.password,


  });


  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};
    json["_id"] = id;
    if(lastName != null) {
      json["lastName"] = lastName;
    }
    if(firstName != null){
      json["firstName"] = firstName.toString();
    }

    if(role != null){
      json["role"] = role;
    }
    if(bio != null){
      json["bio"] = bio;
    }
    if(phone != null)json["phone"] = phone;
    if(password != null)json["password"] = password;




    return json;
  }

}