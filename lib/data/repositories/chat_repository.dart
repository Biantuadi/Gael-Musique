import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/data_base/database_client.dart';
import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/message_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  ChatRepository({required this.sharedPreferences, required this.dioClient});


  Future<ApiResponse?> getUsers({int? page})async{
    Response response = await dioClient.get(AppConfig.usersUrl, queryParameters : {
      "page":page
    });
    return ApiResponse(response: response);
  }

  Future<String?> getUserID()async{
    return  sharedPreferences.getString(AppConfig.sharedUserID);
  }

  Future<List<Chat>> getChatsFromDb() async{
    String userId = await getUserID() ?? '';
    List<Chat> chats = [];
    var db = DatabaseHelper.instance;
    await db.fetchChats(userId).then(
            (value){
          chats = value;
        }
    );
    return chats;
  }

  Future<Chat?> getOneChatFromDB({required String chatID})async{
    var db = DatabaseHelper.instance;
    await db.fetchChat(chatID).then((value)=>value);
    return null;
  }

  Future<List<Message>> getMessagesFromDb({required String chatID}) async{
    List<Message> messages = [];
    var db = DatabaseHelper.instance;
    await db.fetchMessages(chatID).then(
            (value){
          messages = value;
        }
    );
    return messages;
  }

  upsertChat({required Chat chat})async{
    var db = DatabaseHelper.instance;
    return db.upsertChat(chat);
  }

  upsertMessage({required Message message})async{
    var db = DatabaseHelper.instance;
    db.upsertMessage(message);
  }
  deleteChat({required String id}){
    var db = DatabaseHelper.instance;
    db.deleteChat(id);
  }
  deleteMessage({required String id}){
    var db = DatabaseHelper.instance;
    db.deleteMessage(id);
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