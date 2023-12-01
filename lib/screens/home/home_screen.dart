import 'package:Gael/utils/theme_variables.dart';
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

    return Scaffold(
        body: Container(
      child: Column(children: [
        Center(
          child: Text(
            "Gael",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: primaryColor,
                ),
          ),
        ),
      ]),
    ));
  }
}
