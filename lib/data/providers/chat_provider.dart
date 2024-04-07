 import 'package:Gael/data/models/app/response_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier{
  ChatRepository chatRepository;
  ChatProvider({required this.chatRepository,});

  List<User>? users ;
  bool isLoading = false;
  String? getUserError;

  String? chatKeySearch;

  setChatKeySearch(String key)async{
    chatKeySearch = key;
    notifyListeners();
  }

  getUsers()async{
    isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await chatRepository.getUsers();
    isLoading = false;
    notifyListeners();
    if(apiResponse != null){
      if(apiResponse.response.statusCode == 200){
        Map<String, dynamic> data = apiResponse.response.data;
        users = users??[];
        users!.add(User.fromJson(data));
      }
    }else{
      getUserError = "Erreur inconnue";
    }
    isLoading = false;
    notifyListeners();
  }
}