// ignore_for_file: avoid_print

import 'dart:io';

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
  updateUserAvatar({required VoidCallback successCallBack, required VoidCallback errorCallback,required File avatar})async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.updateAvatar(avatar: avatar);
    isLoading = false;
    notifyListeners();
    if(apiResponse != null){
      print("LA RESPONSE: ${apiResponse.response.statusCode}");
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        userToken = data["token"];
        userProfileUrl = data["avatar"];
        authRepository.setUserProfileUrl(userProfileUrl??"");
        authRepository.setUserToken(userToken??"");
        setUserVars();
        print("LES DATES RECUES: $data");
        successCallBack();
      }

    }else{
      registerError = "Erreur inconnue";
      errorCallback();
    }
    isLoading = false;
    notifyListeners();

  }
  register({required VoidCallback successCallBack, required VoidCallback errorCallback})async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.register(registerModel: registerModel);
    isLoading = false;
    notifyListeners();
    if(apiResponse != null){
      print("LA RESPONSE: ${apiResponse.response.statusCode}");
        if(apiResponse.response.statusCode == 200){
          Map<String, dynamic> data = apiResponse.response.data;
          userEmail = data['user']["email"];
          userName = data['user']["lastname"];
          userFirstName = data['user']["firstname"];
          userToken = data["token"];
          userPhone = data['user']["phone"];
          userBio = data['user']["bio"];
          userProfileUrl = data['user']['avatar'];
            setUserVars();
            print("LES DATES RECUES: $data");
            successCallBack();
        }

    }else{
      registerError = "Erreur inconnue";
      errorCallback();
    }
    isLoading = false;
    notifyListeners();

  }
  
  login(LoginModel loginModel, {required VoidCallback successCallBack, required VoidCallback errorCallback})async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.login(loginModel);
    print("LA STRUCTURE LA DE RESPONSE: ${apiResponse?.response.statusMessage}");
    isLoading = false;
    if(apiResponse != null){
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        print("LES DATAS RECUES: $data");
        userEmail = data['user']['email'];
        print("LE MAIL!: ${data['user']['email']}");
        userName = data['user']['lastname'];
        print("LA USER NAME:${data['user']['lastname']}");
        userFirstName = data['user']['firstname'];
        print("FIRST NAME: ${ data['user']['firstname']}");
        userToken = data['token'];
        print("LA TOKEN: ${data['token']}");
        userPhone = data['user']["phone"];
        userBio = data['user']["bio"];
        userProfileUrl = data['user']['avatar'];
        notifyListeners();
        setUserVars();
        successCallBack();
      }
    }else{
      registerError = "Erreur inconnue";
      errorCallback();
    }

    notifyListeners();
  }
  logOut(){
    authRepository.logOut();
  }
  setUserVars()async{
    await authRepository.setUserToken(userToken!);
    await authRepository.setUserBio(userBio??"");
    await authRepository.setUserEmail(userEmail??registerModel.email??"");
    await authRepository.setUserFirstName(userFirstName??registerModel.firstName??"");
    await authRepository.setUserUserName(userName??registerModel.lastName??"");
    await authRepository.setUserPhone(userPhone??registerModel.phone??"");
    await authRepository.setUserProfileUrl(userProfileUrl??"");

  }
  getUserVars()async{
    userProfileUrl = await authRepository.getUserProfileUrl();
    userPhone = await authRepository.getUserPhone();
    userName = await authRepository.getUserName();
    userFirstName = await authRepository.getUserFirstName();
    userToken = await authRepository.getUserToken();
    userEmail = await authRepository.getUserEmail();
    notifyListeners();
  }
}