import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/components/images/image_base64_widget.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ChatListItem extends StatefulWidget {
  final Chat chat;

  const ChatListItem({
    Key? key,
    required this.chat,
  }) : super(key: key);
  @override
  ChatListItemState createState()=>ChatListItemState();
}
class ChatListItemState extends State<ChatListItem> {
  User? user1;
  User? user2;
  String userName = "";
  bool isOnline = false;
  bool isLastMessageMine = true;
  bool isReceivedMessage = false;
  String imageUrl = "";
  String lastMessage = "";
  bool isReadMessage = false;
  String lastMessageTime  = "" ;
  getInfo()async{
      user1 = widget.chat.user1;
      user2 = widget.chat.user2;
      userName = user1!=null? "${user1!.firstName} ${user1!.lastName}" : "";
      isOnline = user1 != null? user1!.isConected??false : false;
      imageUrl = user1 != null? user1!.profileImage : "";
      if(user2 != null && user1 != null){
        if(Provider.of<AuthProvider>(context, listen: false).user!.id == user1!.id){
          userName = "${user2!.firstName} ${user2!.lastName}";
          isOnline = user2!.isConected??false;
          imageUrl = user2!.profileImage;
        }
      }

      if(widget.chat.messages.isNotEmpty){
        lastMessage = widget.chat.messages.last.content;
        if(widget.chat.messages.last.user == Provider.of<AuthProvider>(context, listen: false).user){
          isLastMessageMine = true;
          isReceivedMessage = widget.chat.messages.last.read;
        }
        isReadMessage = widget.chat.messages.last.read;

      }

      if(widget.chat.messages.isNotEmpty){
        lastMessageTime =  "${widget.chat.messages.last.sentAt.hour}:${widget.chat.messages.last.sentAt.minute}";
      }

  }
  @override
  void initState() {
    super.initState();
    getInfo();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.list,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.spacingSizeDefault, vertical: 0),
      onTap: () {
        Navigator.pushNamed(context, Routes.chatDetailScreen, arguments: widget.chat);
        },
      leading: buildLeading(isOnline, imageUrl),
      titleAlignment:ListTileTitleAlignment.center,
      title: Text(
        userName,
        style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
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
