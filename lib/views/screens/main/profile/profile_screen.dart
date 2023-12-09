import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:Gael/views/components/layouts/custom_navbar_bottom.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomHeader(
            showLogo: true,
            showAvatar: true,
            title: "",
            showBackButton: false,
          ),
        ],
      ),

    );
  }
}