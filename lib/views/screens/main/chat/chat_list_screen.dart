import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/views/components/chat_list_items.dart';
import 'package:flutter/material.dart';
import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:Gael/views/components/custom_text_field.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => CchatListScreenState();
}

class CchatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(
            title: "Messages",
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: themeProvider.spacingSizeDefault),
            child: CustomTextField(
              controller: _searchController,
              onChanged: (value) {
                // Utilize the input value here
                // print('Search query: $value');
              }, hintText: 'Recherche...',
              prefixIcon: Icon(Iconsax.search_zoom_out, color: Theme.of(context).primaryColor, size: themeProvider.iconSizeSmall,),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.zero,
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
          ),
        ],
      ),
    );
  }
}
