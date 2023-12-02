import 'package:Gael/components/layouts/custom_header.dart';
import 'package:Gael/components/layouts/custom_navbar_bottom.dart';
import 'package:Gael/components/search_input.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(
            showLogo: false,
            showAvatar: false,
            title: "Messages",
            showBackButton: false,
          ),
          const SizedBox(height: 30),
          SearchInput(
            controller: _searchController,
            onChanged: (value) {
              // Utilisez la valeur de l'entrée ici
              // print('Search query: $value');
            },
          ),
          // const SizedBox(height: 30),
          // Todo: Add a list of messages
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_960_720.png'),
                  ),
                  title: Text('User $index',
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text('Message $index',
                      style: TextStyle(color: Colors.white.withOpacity(0.5))),
                  trailing: Text('12:00',
                      style: TextStyle(color: Colors.white.withOpacity(0.5))),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavbarBottom(
        isChat: true,
      ),
    );
  }
}
