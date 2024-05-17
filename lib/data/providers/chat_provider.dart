 // ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

 import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/message_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/repositories/chat_repository.dart';
import 'package:Gael/utils/string_extensions.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier{
  ChatRepository chatRepository;
  ChatProvider({required this.chatRepository,});

  List<User>? users ;
  List<User>? usersToShow ;
  bool isLoading = false;
  String? getUserError;
  List<Chat>? chats;
  List<Chat>? chatsToShow;
  String? chatKeySearch;
  String? usersKeySearch;
  setChatKeySearch(String key)async{
    chatKeySearch = key.trim();
    chatsToShow = chatsToShow??[];
    if(chatKeySearch != ""){
      chatsToShow = chatsToShow!.where((chat){
        String name1 = "${chat.user1.firstName} ${chat.user1.lastName}";
        String name2 = "${chat.user2.firstName} ${chat.user2.lastName}";
        return(
            name1.replaceSpecials().contains(key.replaceSpecials()) &&
                name2.replaceSpecials().contains(key.replaceSpecials())
        );
      }).toList();
    }else{
      chatsToShow = chats;
    }
    notifyListeners();
  }
  setUsersKeySearch(String key)async{
    usersKeySearch = key.trim();
    usersToShow = usersToShow??[];
    if(usersKeySearch != ""){
      usersToShow = usersToShow!.where((user){
        String name1 = "${user.firstName} ${user.lastName}";
        return  name1.replaceSpecials().contains(key.replaceSpecials());

      }).toList();
    }else{
      usersToShow = users;
    }
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
        List data = apiResponse.response.data["users"]??[];
        userTotalItems = apiResponse.response.data["totalUsers"]??0;
        userCurrentPage = apiResponse.response.data["currentPage"]??0;
        userTotalPages = apiResponse.response.data["totalPages"]??0;
        users = users??[];
        usersToShow = usersToShow??[];
        data.forEach((user) async{
          users!.add(User.fromJson(user));
          await chatRepository.upsertUser(user: User.fromJson(user));
        });
        usersToShow = users;
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
    chatsToShow = chats;
    notifyListeners();
  }



}