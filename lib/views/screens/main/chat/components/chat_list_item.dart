import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../components/images/network_image_widget.dart';

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
      style: ListTileStyle.list,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault, vertical: 0),
      onTap: () {
        Navigator.pushNamed(context, Routes.chatDetailScreen);
        },
      leading: buildLeading(),
      titleAlignment:ListTileTitleAlignment.center,
      title: Text(
        userName,
        style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      ),
      subtitle: buildSubtitle(context),
      trailing: Text(
        lastMessageTime,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.listChatTextColor, fontSize: Theme.of(context).textTheme.bodySmall!.fontSize!/ 1.2),
      ),
    );
  }

  Widget buildLeading() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        NetWorkImageWidget(imageUrl: imageUrl, size:  const Size(45, 45),),
        if (isOnline)
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.spacingSizeDefault,
              top: Dimensions.spacingSizeDefault,
            ),
            child: Container(
              width: Dimensions.iconSizeExtraSmall,
              height: Dimensions.iconSizeExtraSmall,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border(
                  top: BorderSide(color: ThemeVariables.backgroundBlack, width: 1.5),
                  left: BorderSide(color: ThemeVariables.backgroundBlack, width: 1.5),
                  bottom: BorderSide(color: ThemeVariables.backgroundBlack, width: 1.5),
                  right: BorderSide(color: ThemeVariables.backgroundBlack, width: 1.5),
                )
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
          const Icon(Iconsax.check, color: ThemeVariables.primaryColor, ),
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
          Icon(Iconsax.check, color: ThemeVariables.listChatTextColor),
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
