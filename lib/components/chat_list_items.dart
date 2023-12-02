import 'package:Gael/routes/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';

class ChatListItem extends StatelessWidget {
  final bool isLastMessageMine;
  final bool isReceivedMessage;
  final bool isReadMessage;
  final bool isOnline;
  final String userName;
  final String imageUrl;
  final String lastMessage;
  final String lastMessageTime;

  const ChatListItem({
    Key? key,
    required this.isLastMessageMine,
    required this.isReceivedMessage,
    required this.isReadMessage,
    required this.isOnline,
    required this.userName,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastMessageTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Handle item click, navigate to another page, and pass data
        // Navigator.pushNamed(context, Routes.chatDetailScreen, arguments: {
        //   'userName': userName,
        //   'imageUrl': imageUrl,
        // });
        Navigator.pushNamed(context, Routes.chatDetailScreen);

        // dans le fichier chat_detail_screen.dart
      },
      leading: buildLeading(),
      title: Text(
        userName,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      subtitle: buildSubtitle(),
      trailing: Text(
        lastMessageTime,
        style: TextStyle(color: AppTheme.listChatTextColor),
      ),
    );
  }

  Widget buildLeading() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
        if (isOnline)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildSubtitle() {
    if (isLastMessageMine) {
      return Text(
        lastMessage,
        style: TextStyle(color: AppTheme.listChatTextColor),
      );
    } else if (isReceivedMessage && isReadMessage) {
      return Row(
        children: [
          const Icon(Icons.done_all, color: AppTheme.primaryColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    } else if (isReceivedMessage) {
      return Row(
        children: [
          Icon(Icons.check, color: AppTheme.listChatTextColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    } else if (isReadMessage) {
      return Row(
        children: [
          const Icon(Icons.done_all, color: AppTheme.primaryColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.done_all, color: AppTheme.listChatTextColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    }
  }
}
