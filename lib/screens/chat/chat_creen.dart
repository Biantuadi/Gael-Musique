import 'package:Gael/components/layouts/custom_header.dart';
import 'package:Gael/components/layouts/custom_navbar_bottom.dart';
import 'package:Gael/components/search_input.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  // final bool _isSearching = false;
  final bool _isLastMessageMine = false;
  final bool _isReceivedMessage = true;
  final bool _isReadMessage = false;
  final bool _isOnline = true;

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
              // Utilisez la valeur de l'entrée ici
              // print('Search query: $value');
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://picsum.photos/250?image=9'),
                      ),
                      if (_isOnline)
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
                  ),
                  title: Text('User $index',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                  subtitle: buildSubtitle(),
                  trailing: Text('12:00',
                      style: TextStyle(color: AppTheme.listChatTextColor)),
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

  // Fonction pour construire le sous-titre en fonction des conditions
  Widget? buildSubtitle() {
    if (_isLastMessageMine) {
      return Text(
        'is mine',
        style: TextStyle(color: AppTheme.listChatTextColor),
      );
    } else if (_isReceivedMessage && _isReadMessage) {
      // Sous-titre avec une icône de double check verte pour un message reçu et lu
      return Row(
        children: [
          const Icon(Icons.done_all, color: AppTheme.primaryColor, size: 16),
          const SizedBox(width: 5),
          Text(
            'Received and Read',
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    } else if (_isReceivedMessage) {
      // Sous-titre avec une icône de check pour un message reçu
      return Row(
        children: [
          Icon(Icons.check, color: AppTheme.listChatTextColor, size: 16),
          const SizedBox(width: 5),
          Text(
            'Received',
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    } else {
      // Sous-titre avec une icône de double check pour un message non lu
      return Row(
        children: [
          Icon(Icons.done_all, color: AppTheme.listChatTextColor, size: 16),
          const SizedBox(width: 5),
          Text(
            'Unread',
            style: TextStyle(color: AppTheme.listChatTextColor),
          ),
        ],
      );
    }
  }
}
