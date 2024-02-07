 import 'package:Gael/data/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier{
  ChatRepository chatRepository;
  ChatProvider({required this.chatRepository});
}