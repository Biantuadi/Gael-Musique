import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/screens/main/chat/components/chat_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gael/views/components/fields/custom_text_field.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool showAppBar = true;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          showAppBar = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          showAppBar = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(builder: (ctx, provider, child){
      return CustomScrollView(
        slivers: [
          SliverList.list(children: [ Container(
            color: ThemeVariables.thirdColorBlack,
            padding: EdgeInsets.only(
                top: Dimensions.spacingSizeDefault * 3,
                left: Dimensions.spacingSizeDefault
            ),
            child: Text("Messages",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
          )]),
          SliverAppBar(
            pinned: true,
            backgroundColor: ThemeVariables.thirdColorBlack,
            title: CustomTextField(
              onChanged: (value) {
              provider.chatProvider.setChatKeySearch(value);
              }, hintText: 'Recherche...',
            ),
          ),
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ChatListItem(
                isLastMessageMine: false,
                isReceivedMessage: false,
                isReadMessage: true,
                isOnline: true,
                userName: 'User $index',
                imageUrl: 'https://picsum.photos/250?image=9',
                lastMessage: 'Last message $index',
                lastMessageTime: '10:00',
              );
            },
          ),
        ],
      );
    });
  }
}
