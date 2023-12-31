import 'package:Gael/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
  AuthRepository authRepository;
  AuthProvider({required this.authRepository});
  Map<String, dynamic> registerInfo = {};
  setNames({required String name, required String firstName}){
      registerInfo["name"] = name;
      registerInfo["firstName"] = firstName;
      notifyListeners();
  }
  setInfo({required String email, required String phone}){
    registerInfo["email"] = email;
    registerInfo["phone"] = phone;
    notifyListeners();
  }
  setPassword(String password){
    registerInfo["password"] = password;
    notifyListeners();
  }
}