// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/models/app/login_model.dart';
import 'package:Gael/data/models/app/register_model.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  AuthRepository({required this.sharedPreferences, required this.dioClient});
  Future<ApiResponse?> register({required RegisterModel registerModel})async{
    //print("LA FORM DATA: ${registerModel.toJson()}");
    Response response = await dioClient.post(AppConfig.registerUrl,data: registerModel.toJson());
    return ApiResponse(response: response);
  }

  Future<ApiResponse?> updateAvatar({required File avatar})async{
    File? file = avatar;
    String fileName = '';
    fileName = file.path.split('/').last;
    print("LA FILE: ${file.path}");
    FormData formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(file.path, filename: fileName),
    });


    Response response = await dioClient.post(AppConfig.registerUrl,data: {"avatar" : avatar.readAsBytesSync()},);
      //print("LA STATUS CODE: ${response.statusCode} ");
      return ApiResponse(response: response);
  }
  Future<ApiResponse?> login(LoginModel loginModel)async{
      Response response = await dioClient.post(AppConfig.loginUrl,data: loginModel.toJson());
      return ApiResponse(response: response);
  }
  setUserEmail(String email)async{
    await sharedPreferences.setString(AppConfig.sharedEmail, email);
  }
  setUserUserName(String name)async{
    await sharedPreferences.setString(AppConfig.sharedUserName, name);
  }
  setUserFirstName(String firstName)async{
    await sharedPreferences.setString(AppConfig.sharedEmail, firstName);
  }
  setUserProfileUrl(String profileUrl)async{
    await sharedPreferences.setString(AppConfig.sharedProfileUrl, profileUrl);
  }
  setUserPhone(String phone)async{
    await sharedPreferences.setString(AppConfig.sharedPhone, phone);
  }
  setUserBio(String bio)async{
    await sharedPreferences.setString(AppConfig.sharedUserBio, bio);
  }
  setUserToken(String token)async{
    await sharedPreferences.setString(AppConfig.sharedToken, token);
  }
  Future<String?> getUserToken()async{
    return  sharedPreferences.getString(AppConfig.sharedToken);
  }
  Future<String?> getUserName()async{
    return  sharedPreferences.getString(AppConfig.sharedUserName);
  }
  Future<String?> getUserProfileUrl()async{
    return  sharedPreferences.getString(AppConfig.sharedProfileUrl);
  }
  Future<String?> getUserFirstName()async{
    return  sharedPreferences.getString(AppConfig.sharedFirstName);
  }

  Future<String?> getUserPhone()async{
    return  sharedPreferences.getString(AppConfig.sharedPhone);
  }
  Future<String?> getUserEmail()async{
    return  sharedPreferences.getString(AppConfig.sharedEmail);
  }
  Future<String?> getUserBio()async{
    return  sharedPreferences.getString(AppConfig.sharedUserBio);
  }
  logOut(){
    sharedPreferences.remove(AppConfig.sharedToken);
    sharedPreferences.remove(AppConfig.sharedUserBio);
    sharedPreferences.remove(AppConfig.sharedPhone);
    sharedPreferences.remove(AppConfig.sharedProfileUrl);
    sharedPreferences.remove(AppConfig.sharedUserName);
    sharedPreferences.remove(AppConfig.sharedEmail);
    sharedPreferences.remove(AppConfig.sharedFirstName);
  }
}