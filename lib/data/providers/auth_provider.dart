import 'package:Gael/data/models/app/login_model.dart';
import 'package:Gael/data/models/app/register_model.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
  AuthRepository authRepository;
  AuthProvider({required this.authRepository});
   RegisterModel registerModel = RegisterModel();
  bool isLoading = false;
  String? registerError;
  String? userToken;
  String? userName;
  String? userFirstName;
  String? userEmail;
  String? userPhone;
  String? userBio;
  String? userProfileUrl;

  setRegisterNames({required String name, required String firstName}){
      registerModel.lastName = name;
      registerModel.firstName = firstName;
      notifyListeners();
  }
  setRegisterInfo({required String email, required String phone}){
    registerModel.email = email;
    registerModel.phone = phone;
    notifyListeners();
  }
  setRegisterPassword(String password){
    registerModel.password = password;
    notifyListeners();
  }
  getUserInfo(){

  }
  register()async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.register(registerModel: registerModel);
    if(apiResponse != null){
        if(apiResponse.response.statusCode == 200){
          Map<String, dynamic> data = apiResponse.response.data;
            userEmail = data["email"];
            userName = data["last_name"];
            userFirstName = data["first_name"];
            userToken = data["token"];
            userPhone = data["phone"];
            userBio = data["bio"];
            await authRepository.setUserBio(userBio!);
            await authRepository.setUserEmail(userEmail!);
            await authRepository.setUserFirstName(userFirstName!);
            await authRepository.setUserUserName(userName!);
            await authRepository.setUserPhone(userPhone!);
            await authRepository.setUserProfileUrl(userProfileUrl!);
        }
    }else{
      registerError = "Erreur inconnue";
    }
    isLoading = false;
    notifyListeners();

  }
  login(LoginModel loginModel)async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.login(loginModel);
    if(apiResponse != null){
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        userEmail = data["email"];
        userName = data["last_name"];
        userFirstName = data["first_name"];
        userToken = data["token"];
        userPhone = data["phone"];
        userBio = data["bio"];
        await authRepository.setUserBio(userBio!);
        await authRepository.setUserEmail(userEmail!);
        await authRepository.setUserFirstName(userFirstName!);
        await authRepository.setUserUserName(userName!);
        await authRepository.setUserPhone(userPhone!);
        await authRepository.setUserProfileUrl(userProfileUrl!);
      }
    }else{
      registerError = "Erreur inconnue";
    }
    isLoading = false;
    notifyListeners();
  }
}