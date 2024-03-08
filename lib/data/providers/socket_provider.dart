import 'package:Gael/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketProvider with ChangeNotifier{

  late io.Socket socket;
  bool socketAsError = false;

  void initSocket() {
    socket = io.io(AppConfig.BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connexion établie');
      // Ajoutez ici votre logique lorsque la connexion est établie
      // Par exemple, récupérez tous les messages ou écoutez les nouveaux messages
    });

    socket.onDisconnect((_) => print('Connexion interrompue'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }

  getEvent(){
    socket.on('getMessageEvent', (newMessage) {
      // Ajoutez ici la logique pour gérer le nouveau message
      // Par exemple, ajoutez le message à une liste de messages
    });

  }
  void sendMessage() {
    String message ="".trim();
    if (message.isEmpty) return;

    Map<String, dynamic> messageMap = {
      'message': message,
      //'senderId': userId, // Remplacez par l'ID de l'utilisateur actuel
      // Ajoutez d'autres données si nécessaire
    };

    socket.emit('sendMessageEvent', messageMap);
  }



}