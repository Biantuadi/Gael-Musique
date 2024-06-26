// ignore_for_file: avoid_print

import 'dart:io';
import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/data_base/database_client.dart';
import 'package:Gael/data/models/app/login_model.dart';
import 'package:Gael/data/models/app/register_model.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/app/user_updaate_model.dart';
import 'package:Gael/data/models/user_model.dart';
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
    FormData formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    String? userId = await getUserID();

    Response response = await dioClient.post("${AppConfig.avatarUpdateUrl}$userId",data: formData,);

      return ApiResponse(response: response);
  }

  Future<ApiResponse?> updateUserInfo({required UserUpdate userUpdate})async{
    String? userId = await getUserID();
    userUpdate.id = userId;
    Response response = await dioClient.put("${AppConfig.userUrl}$userId",data: userUpdate.toJson(),);
    return ApiResponse(response: response);
  }
  Future<ApiResponse?> updateUserPassword({required Map<String, String> passwordMap})async{
    Response response = await dioClient.put(AppConfig.passwordUpdate,data: passwordMap,);
    return ApiResponse(response: response);
  }

  Future<ApiResponse?> getUser()async{
    String? userId = await getUserID();

    Response response = await dioClient.get("${AppConfig.userMeUrl}$userId",);
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
    await sharedPreferences.setString(AppConfig.sharedFirstName, firstName);
  }
  setUserProfileUrl(String profileUrl)async{
    await sharedPreferences.setString(AppConfig.sharedProfileUrl, profileUrl);
  }
  setUserID(String userID)async{
    await sharedPreferences.setString(AppConfig.sharedUserID, userID);
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
  setUserCreatedAt(String createdAt)async{
    await sharedPreferences.setString(AppConfig.sharedUserCreatedAt, createdAt);
  }
  setUserTokenDate(DateTime tokenDate)async{
    String tokenDateStr = tokenDate.toString();
    await sharedPreferences.setString(AppConfig.sharedTokenDate, tokenDateStr);
  }
  Future<String?> getUserToken()async{
    return  sharedPreferences.getString(AppConfig.sharedToken);
  }
  Future<String?> getUserTokenDate()async{
    return  sharedPreferences.getString(AppConfig.sharedTokenDate);
  }
  Future<bool?> isTokenValid()async{
    String? tokenDateStr =  sharedPreferences.getString(AppConfig.sharedTokenDate);
    if(tokenDateStr != null){
      DateTime tokenDate = DateTime.parse(tokenDateStr);
      bool isMoreThanOneDay = !((DateTime.now().day - tokenDate.day) > 0);
      return isMoreThanOneDay;
    }
    return false;
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
  Future<String?> getUserID()async{
    return  sharedPreferences.getString(AppConfig.sharedUserID);
  }
  Future<String?> getUserCreatedAt()async{
    return  sharedPreferences.getString(AppConfig.sharedUserCreatedAt);
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
    sharedPreferences.remove(AppConfig.sharedUserID);
  }

  Future<List<User>> getUsersFromDb() async{
    var db = DatabaseHelper.instance;
    await db.fetchUsers().then(
            (value){
          return value;
        }
    );
    return [];
  }

  Future<User?> getOneUserFromDB({required String userID})async{
    var db = DatabaseHelper.instance;
    await db.fetchUser(userID).then((value)=>value);
    return null;
  }

  upsertUser({required User user})async{
    var db = DatabaseHelper.instance;
    await db.upsertUser(user);
  }

  deleteUser({required String id}){
    var db = DatabaseHelper.instance;
    db.deleteUser(id);
  }


}