 // ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

 import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/message_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier{
  ChatRepository chatRepository;
  ChatProvider({required this.chatRepository,});

  List<User>? users ;
  bool isLoading = false;
  String? getUserError;
  List<Chat>? chats;
  String? chatKeySearch;
  setChatKeySearch(String key)async{
    chatKeySearch = key;
    notifyListeners();
  }

  int userTotalItems =0;
  int userCurrentPage =0;
  int userTotalPages =0;

  incrementCurrentPage(){
    if(userCurrentPage < userTotalPages){
      userCurrentPage++;
      getUsersFromApi();
    }
  }


  getUsersFromApi()async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await chatRepository.getUsers(page: userCurrentPage>0? userCurrentPage:null);
    isLoading = false;
    notifyListeners();
    if(apiResponse != null){
      if(apiResponse.response.statusCode == 200){
        print("LES USERS: ${apiResponse.response.data.keys}");
        List data = apiResponse.response.data["users"]??[];
        userTotalItems = apiResponse.response.data["totalUsers"]??0;
        userCurrentPage = apiResponse.response.data["currentPage"]??0;
        userTotalPages = apiResponse.response.data["totalPages"]??0;
        users = users??[];
        data.forEach((user) async{
          users!.add(User.fromJson(user));
          await chatRepository.upsertUser(user: User.fromJson(user));
        });
      }
    }else{
      getUserError = "Erreur inconnue";
    }
    isLoading = false;
    notifyListeners();
  }

  upsertChat(Chat chat)async{
    await chatRepository.upsertChat(chat: chat);
  }
  upsertMessage(Message message)async{
    await chatRepository.upsertMessage(message: message);
  }

  getUsersFromDB()async{
    users = users??[];
    users = await chatRepository.getUsersFromDb();
    notifyListeners();
  }
  getChatsFromDB()async{
    chats = chats??[];
    chats = await chatRepository.getChatsFromDb();
    notifyListeners();
  }



}