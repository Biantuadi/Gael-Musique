import 'package:Gael/data/repositories/socket_repository.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


class SocketProvider with ChangeNotifier{
  final SocketRepository socketRepository;
  SocketProvider({
    required this.socketRepository,

  });

  late io.Socket socket;
  bool socketAsError = false;

  void initSocket({
    required Function errorCallBack,
    required Function connectErrorCallBack,
    required VoidCallback successCallback,
    required VoidCallback disconnectCallBack,
    required bool userIsAuthenticated
  }) {
    socket = io.io(AppConfig.BASE_URL, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    try{
      socket.connect();
      socket.onConnect((_) {
        successCallback();
        onConnected(userIsAuthenticated);
        // Ajoutez ici votre logique lorsque la connexion est établie
        // Par exemple, récupérez tous les messages ou écoutez les nouveaux messages
      });
    }
    catch (e){
      errorCallBack(e);
    }
    socket.onError((err) => errorCallBack(err));
    socket.onDisconnect((_) => disconnectCallBack());
    socket.onConnectError((err) => connectErrorCallBack(err));

  }
  onMessageReceived(){
    onEvent(event: "onMessageReceived", doOnEvent: (message){

    });
  }

  onEvent({required String event, required Function doOnEvent}){
    socket.on(event, (newMessage) {
        doOnEvent(newMessage);
    });
  }
  onConnected(bool userIsAuthenticated){
    onEvent(event: "onConnected", doOnEvent: (user){
      if(userIsAuthenticated){
        socket.emit("onConnected", {
          "message": "user is authenticated"
        });
      }
    });
  }

  void sendMessage({required String receiverId, required String message, required String userId}) {
    message ="".trim();
    if (message.isEmpty) return;

    Map<String, dynamic> messageMap = {
      'message': message,
      'senderId': userId,
      'receiverId': receiverId,
      // OTHERS PARAMS  DON'T FORGET
    };

    socket.emit('sendMessageEvent', messageMap);
  }



}