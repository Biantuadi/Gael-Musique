import 'package:Gael/components/layouts/custom_header.dart';
import 'package:Gael/components/layouts/custom_navbar_bottom.dart';
import 'package:flutter/material.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
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
      bottomNavigationBar: CustomNavbarBottom(),
    );
  }
}
