import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => CchatDetailScreenState();
}

class CchatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Map<String?, dynamic> data =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(ModalRoute.of(context)!.settings.arguments);
    return const Scaffold(
      body: Column(
        children: [
          CustomHeader(
            showAvatar: true,
            title: "Gaël Music",
            showBackButton: true,
          ),
        ],
      ),
    );
  }
}
