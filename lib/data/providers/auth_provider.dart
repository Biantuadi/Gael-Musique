
import 'dart:io';
import 'dart:ui';

import 'package:Gael/data/models/app/login_model.dart';
import 'package:Gael/data/models/app/register_model.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/app/user_updaate_model.dart';
import 'package:Gael/data/models/preference_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/repositories/auth_repository.dart';
import 'package:countries_info/countries_info.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier{
  AuthRepository authRepository;
  AuthProvider({required this.authRepository});
   RegisterModel registerModel = RegisterModel();
  UserUpdate userUpdate = UserUpdate();
  bool isLoading = false;
  String? registerError;
  String? userToken;
  bool? userTokenIsValid;
  String? userCreatedAt;
  String? userID;
  String? userName;
  String? userFirstName;
  String? userEmail;
  String? userPhone;
  String? userBio;
  String? userProfileUrl;
  String? loginError;
  String? avatarUpdateError;
  String? userUpdateError;
  String? getUserError;
  bool isLoadingData = false;
  User? user;
  Map<String, dynamic> u = {};

  String countrySearchKey = "";
  String countryCode = "";
  String countryFlag = "";

  setInitialCountry(){
    Countries allCountries = Countries();
    List<Map<String, dynamic>> countries = allCountries.name(query: "congo");
    countryCode = countries.last["idd"]["root"]??"- ";
    countryCode += countries.last["idd"]["suffixes"] != null? countries.last["idd"]["suffixes"][0] :"-";
    countryFlag = countries.last["flag"];

  }

  setCountrySearchKey(String value){
    countrySearchKey = value;
    notifyListeners();
  }


  setCountryFlagNCode({required String code, required String flag}){
    countryCode = code;
    countryFlag = flag;
    notifyListeners();
  }


  setUpdateUpdateNames({required String lastName, required String firstName}){
    if(user != null){
      userUpdate.id = user!.id;
      userUpdate.firstName = firstName;
      userUpdate.lastName = lastName;
      notifyListeners();
    }

  }
  emptyUpdateInfo(){
    userUpdate = UserUpdate();
    notifyListeners();
  }
  updateUser({required VoidCallback successCallBack, required VoidCallback errorCallback})async{
    if(user != null && userUpdate.id != null) {
      isLoading = true;
      notifyListeners();
      ApiResponse? apiResponse = await authRepository.updateUserInfo(userUpdate: userUpdate);

      if(apiResponse != null){
        print("LA RESPONSE: ${apiResponse.response}");
        if(apiResponse.response.statusCode == 200){
          Map<String, dynamic> data = apiResponse.response.data;

          await getUser().then(
              (){
                successCallBack();
              }
          );
        }else{
          userUpdateError = apiResponse.response.data["message"];
          errorCallback();
          notifyListeners();
        }
      }else{
        userUpdateError = "Erreur inconnue";
        errorCallback();
      }
      isLoading = false;
      emptyUpdateInfo();
      notifyListeners();
    }else{
      userUpdateError = "informations manquantes...";
    }
    emptyUpdateInfo();
  }


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
          userCreatedAt = data['user']["createdAt"];
          setUserVars().then(
                  (value){
                    isLoadingData = true;
                    notifyListeners();
                    if(userToken != null){
                      successCallBack();
                    }

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
        userCreatedAt = data["user"]["createdAt"];
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
        userCreatedAt = data['user']["createdAt"];
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
    isLoading =false;
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
    await authRepository.setUserTokenDate(DateTime.now());
    await authRepository.setUserCreatedAt(userCreatedAt??"");
    getUserVars();

  }
  getUserVars()async{
    userProfileUrl = await authRepository.getUserProfileUrl();
    userPhone = await authRepository.getUserPhone();
    userName = await authRepository.getUserName();
    userFirstName = await authRepository.getUserFirstName();
    userToken = await authRepository.getUserToken();
    userEmail = await authRepository.getUserEmail();
    userID = await authRepository.getUserID();
    userTokenIsValid = await authRepository.isTokenValid();
    userCreatedAt = await authRepository.getUserCreatedAt();
    DateTime? createdAtDate = DateTime.tryParse(userCreatedAt??"");
    user = User(
        phone: userPhone??"",
        firstName: userFirstName??"",
        id: userID??"",
        bio: '',
        createdAt: createdAtDate??DateTime.now(),
        email: userEmail??'',
        lastName: userName ??"",
        preferences: Preference(theme: '', language: '', notifications: true),
        profileImage: userProfileUrl??""
    );
    notifyListeners();
  }
}