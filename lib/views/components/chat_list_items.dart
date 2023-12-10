import 'package:Gael/utils/routes/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';

import 'network_image_widget.dart';

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
        Navigator.pushNamed(context, Routes.chatDetailScreen);
        },
      leading: buildLeading(),
      title: Text(
        userName,
        style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      ),
      subtitle: buildSubtitle(context),
      trailing: Text(
        lastMessageTime,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.listChatTextColor, ),
      ),
    );
  }

  Widget buildLeading() {
    return Stack(
      children: [
        NetWorkImageWidget(imageUrl: imageUrl, size: const Size(25, 25), radius: 30,),
        if (isOnline)
          Positioned(
            bottom: 0,
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

  Widget buildSubtitle(BuildContext context) {
    TextStyle? textStyle =  Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.listChatTextColor, );
    if (isLastMessageMine) {
      return Text(
        lastMessage,
        style: textStyle,
      );
    } else if (isReceivedMessage && isReadMessage) {


      return Row(
        children: [
          const Icon(Icons.done_all, color: ThemeVariables.primaryColor, ),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: textStyle,
          ),
        ],
      );
    } else if (isReceivedMessage) {
      return Row(
        children: [
          Icon(Icons.check, color: ThemeVariables.listChatTextColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: textStyle),
        ],
      );
    } else if (isReadMessage) {
      return Row(
        children: [
          const Icon(Icons.done_all, color: ThemeVariables.primaryColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: textStyle,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.done_all, color: ThemeVariables.listChatTextColor, size: 16),
          const SizedBox(width: 5),
          Text(
            lastMessage,
            style: TextStyle(color: ThemeVariables.listChatTextColor),
          ),
        ],
      );
    }
  }
}
