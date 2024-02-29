// ignore_for_file: avoid_print

import 'dart:io';

import 'package:Gael/data/models/app/login_model.dart';
import 'package:Gael/data/models/app/register_model.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
  AuthRepository authRepository;
  AuthProvider({required this.authRepository});
   RegisterModel registerModel = RegisterModel();
  bool isLoading = false;
  String? registerError;
  String? userToken;
  String? userID;
  String? userName;
  String? userFirstName;
  String? userEmail;
  String? userPhone;
  String? userBio;
  String? userProfileUrl;
  String? loginError;
  String? avatarUpdateError;
  String? getUserError;
  bool isLoadingData = false;
  User? user;
  Map<String, dynamic> u = {};

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
      print("LA RESPONSE: ${apiResponse.response}");
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        userToken = data["token"];
        userProfileUrl = data["avatar"];
        authRepository.setUserProfileUrl(userProfileUrl??"");
        authRepository.setUserToken(userToken??"");
        getUser();
        successCallBack();
      }else{
        avatarUpdateError = apiResponse.response.data["message"];
        errorCallback();
        notifyListeners();
      }

    }else{
      avatarUpdateError = "Erreur inconnue";
      errorCallback();
    }
    isLoading = false;
    notifyListeners();

  }
  register({required VoidCallback successCallBack, required VoidCallback errorCallback})async{
    isLoading = true;
    registerError = null;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.register(registerModel: registerModel);
    isLoading = false;
    notifyListeners();
    if(apiResponse != null){
      print("LA RESPONSE: ${apiResponse.response}");
        if(apiResponse.response.statusCode == 200){
          Map<String, dynamic> data = apiResponse.response.data;
          userEmail = data['user']['email'];
          userName = data['user']['lastname'];
          userFirstName = data['user']['firstname'];
          userToken = data['token'];
          userPhone = data['user']["phone"];
          userBio = data['user']["bio"];
          userProfileUrl = data['user']['avatar'];
          userID = data['user']['_id'];

          user = User.fromJson(data['user']);
          setUserVars().then(
                  (value){
                    isLoadingData = true;
                    notifyListeners();
                    successCallBack();
                    isLoadingData = false;
              }
          );
        }else{
          registerError = apiResponse.response.data["message"];
        }

    }else{
      registerError = "Erreur inconnue";
      errorCallback();
    }
    isLoading = false;
    notifyListeners();

  }
  getUser()async{
    isLoading = true;
    registerError = null;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.getUser();
    isLoading = false;
    notifyListeners();
    if(apiResponse != null){
      print("LA RESPONSE: ${apiResponse.response}");
      print("LA STATUS: ${apiResponse.response.statusCode}");
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        userEmail = data['user']['email'];
        userName = data['user']['lastname'];
        userFirstName = data['user']['firstname'];
        userToken = data['token'];
        userPhone = data['user']["phone"];
        userBio = data['user']["bio"];
        userProfileUrl = data['user']['avatar'];
        userID = data['user']['_id'];
        setUserVars();
      }
    }else{
      getUserError = "Erreur inconnue";
    }
    isLoading = false;
    notifyListeners();
  }
  nullAuthVars(){
    loginError = null;
    registerError = null;
    avatarUpdateError = null;
    notifyListeners();
  }
  login(LoginModel loginModel, {required VoidCallback successCallBack, required VoidCallback errorCallback})async{
    isLoading = true;
    loginError = null;
    notifyListeners();
    ApiResponse? apiResponse = await authRepository.login(loginModel);
    print("LA STRUCTURE LA DE RESPONSE: ${apiResponse?.response.data}");
    print("LA STATUS CODE: ${apiResponse?.response.statusCode}");
    print("LA STATUS MESG: ${apiResponse?.response.statusMessage}");
    isLoading = false;
    if(apiResponse != null){
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        userEmail = data['user']['email'];
        userName = data['user']['lastname'];
        userFirstName = data['user']['firstname'];
        userToken = data['token'];
        userPhone = data['user']["phone"];
        userBio = data['user']["bio"];
        userProfileUrl = data['user']['avatar'];
        userID = data['user']['_id'];
        user = User.fromJson(data['user']);
        notifyListeners();
        setUserVars().then(
            (value){
              if(userToken != null){
                isLoadingData = true;
                notifyListeners();
                successCallBack();
                isLoadingData = false;
              }

            }

        );

        loginError = null;
      }
      else{
        if(apiResponse.response.data is int || apiResponse.response.data is double){
          loginError = "la requête a pris trop de temps, veillez réessayer!";
        }else{
          if(apiResponse.response.data is Map){
            loginError = apiResponse.response.data["message"];
          }else{
            loginError = "Erreur Inconnue";
          }
        }

        errorCallback();
      }
    }else{
      loginError = "Erreur inconnue";
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
    await authRepository.setUserID(userID??"");


  }
  getUserVars()async{
    userProfileUrl = await authRepository.getUserProfileUrl();
    userPhone = await authRepository.getUserPhone();
    userName = await authRepository.getUserName();
    userFirstName = await authRepository.getUserFirstName();
    userToken = await authRepository.getUserToken();
    userEmail = await authRepository.getUserEmail();
    userID = await authRepository.getUserID();
    notifyListeners();
  }
}