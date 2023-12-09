import 'package:Gael/views/components/chat_list_items.dart';
import 'package:flutter/material.dart';
import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:Gael/views/components/layouts/custom_navbar_bottom.dart';
import 'package:Gael/views/components/search_input.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => CchatListScreenState();
}

class CchatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(
            title: "Messages",
          ),
          const SizedBox(height: 30),
          SearchInput(
            controller: _searchController,
            onChanged: (value) {
              // Utilize the input value here
              // print('Search query: $value');
            },
          ),
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
