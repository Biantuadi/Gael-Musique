import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'auth_provider.dart';
import 'chat_provider.dart';
import 'notification_provider.dart';

class SocketProvider with ChangeNotifier{
  final ChatProvider chatProvider;
  final NotificationProvider notificationProvider;
  final AuthProvider authProvider;
  final StreamingProvider streamingProvider;
  final EventsProvider eventsProvider;
  final SongProvider songProvider;
  SocketProvider({
    required this.chatProvider,
    required this.notificationProvider,
    required this.authProvider,
    required this.streamingProvider,
    required this.songProvider,
    required this.eventsProvider
  });

  late io.Socket socket;
  bool socketAsError = false;

  void initSocket({
    required Function errorCallBack,
    required Function connectErrorCallBack,
    required VoidCallback successCallback,
    required VoidCallback disconnectCallBack,
  }) {
    socket = io.io(AppConfig.BASE_URL, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    try{
      socket.connect();
      socket.onConnect((_) {
        successCallback();
        if(authProvider.userToken != null){
          onConnected();
        }

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
  onConnected(){
    onEvent(event: "onConnected", doOnEvent: (user){

    });
  }

  void sendMessage({required String receiverId, required String message}) {
    message ="".trim();
    if (message.isEmpty) return;

    Map<String, dynamic> messageMap = {
      'message': message,
      'senderId': authProvider.userID,
      'receiverId': receiverId,
      // OTHERS PARAMS  DON'T FORGET
    };

    socket.emit('sendMessageEvent', messageMap);
  }



}