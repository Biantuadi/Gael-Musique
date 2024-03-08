 import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/repositories/chat_repository.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier{
  ChatRepository chatRepository;
  SocketProvider socketProvider;
  ChatProvider({required this.chatRepository, required this.socketProvider});
}