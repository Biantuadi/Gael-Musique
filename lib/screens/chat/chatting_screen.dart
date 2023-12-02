import 'package:Gael/components/layouts/custom_header.dart';
import 'package:Gael/components/layouts/custom_navbar_bottom.dart';
import 'package:flutter/material.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
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
