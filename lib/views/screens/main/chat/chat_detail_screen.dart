import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/views/components/images/image_base64_widget.dart';
import 'package:Gael/views/components/images/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
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
    setState(() {
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
    });
  }
  @override
  Widget build(BuildContext context) {
    // Map<String?, dynamic> data =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(ModalRoute.of(context)!.settings.arguments);
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        title: Row(
          children: [
            Base64ImageWidget(base64String: imageUrl, size: Size(Dimensions.iconSizeExtraLarge * 1.2, Dimensions.iconSizeExtraLarge * 1.2)),

            SizedBox(width: Dimensions.spacingSizeDefault,),
            Text(userName, style: Theme.of(context).textTheme.titleMedium,)
          ],
        ),
      ),
      body: const Column(
        children: [
        ],
      ),
    );
  }
}
