import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/images/image_base64_widget.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ChatListItem extends StatelessWidget {
 final Chat chat;
  const ChatListItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = "${chat.user1.firstName} ${chat.user1.lastName}";
    bool isOnline = chat.user1.isConected??false;
    bool isLastMessageMine = true;
    bool isReceivedMessage = false;
    String imageUrl = chat.user1.profileImage;
    if(Provider.of<AuthProvider>(context, listen: false).user!.id == chat.user1.id){
      userName = "${chat.user2.firstName} ${chat.user2.lastName}";
      isOnline = chat.user2.isConected??false;
      imageUrl = chat.user2.profileImage;
    }
    String lastMessage = "";
    bool isReadMessage = false;
    if(chat.messages.isNotEmpty){
      lastMessage = chat.messages.last.content;
      if(chat.messages.last.user == Provider.of<AuthProvider>(context, listen: false).user){
        isLastMessageMine = true;
        isReceivedMessage = chat.messages.last.read;
      }
       isReadMessage = chat.messages.last.read;

    }

    String lastMessageTime  = "" ;
    if(chat.messages.isNotEmpty){
      lastMessageTime =  "${chat.messages.last.sentAt.hour}:${chat.messages.last.sentAt.minute}";
    }
    return ListTile(
      style: ListTileStyle.list,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault, vertical: 0),
      onTap: () {
        Navigator.pushNamed(context, Routes.chatDetailScreen);
        },
      leading: buildLeading(isOnline, imageUrl),
      titleAlignment:ListTileTitleAlignment.center,
      title: Text(
        userName,
        style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      ),
      subtitle: buildSubtitle(context,isLastMessageMine,isReadMessage,lastMessage, isReceivedMessage),
      trailing: Text(
        lastMessageTime,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ThemeVariables.listChatTextColor, fontSize: Theme.of(context).textTheme.bodySmall!.fontSize!/ 1.2),
      ),
    );
  }

  Widget buildLeading(bool isOnline, String imageUrl) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Base64ImageWidget(base64String: imageUrl, size: Size(Dimensions.iconSizeExtraLarge * 1.2, Dimensions.iconSizeExtraLarge*1.2), radius: Dimensions.radiusSizeExtraSmall,),
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

  Widget buildSubtitle(BuildContext context, bool isLastMessageMine, bool isReadMessage, String lastMessage, bool isReceivedMessage) {
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
class ChatItemShimmer extends StatelessWidget{
  const ChatItemShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Row(
      children: [
        Shimmer.fromColors(
            baseColor: ThemeVariables.thirdColor,
            highlightColor: Colors.grey,
            child: Container(
              height: Dimensions.iconSizeExtraLarge * 1.2,
              width: Dimensions.iconSizeExtraLarge * 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
              ),
            )
        ),
        SizedBox(width: Dimensions.spacingSizeDefault,),
        Expanded(child: Column(
          children: [
            Shimmer.fromColors(
                baseColor: ThemeVariables.thirdColor,
                highlightColor: Colors.grey,
                child: Container(
                  height: Dimensions.spacingSizeSmall,
                  width: size.width/2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
                  ),
                )
            ),
            SizedBox(
              height: Dimensions.spacingSizeExtraSmall,
            ),
            Shimmer.fromColors(
                baseColor: ThemeVariables.thirdColor,
                highlightColor: Colors.grey,
                child: Container(
                  height: Dimensions.spacingSizeSmall/2,
                  width: size.width/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall)
                  ),
                )
            ),
          ],
        ))
      ],
    );
  }
}
