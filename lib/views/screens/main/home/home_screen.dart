import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:Gael/views/components/layouts/custom_navbar_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

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
    Size size = MediaQuery.sizeOf(context);
    return const Scaffold(
      body: Column(
        children: [
          CustomHeader(
            showLogo: true,
            showAvatar: true,
          ),
        ],
      ),
    );
  }
}
