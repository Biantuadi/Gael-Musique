import 'package:Gael/components/layouts/custom_header.dart';
import 'package:Gael/components/layouts/custom_navbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

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
      bottomNavigationBar: CustomNavbarBottom(
        isHome: true,
      ),
    );
  }
}
