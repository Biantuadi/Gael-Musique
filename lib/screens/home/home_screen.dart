import 'package:Gael/components/ellipsis.dart';
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
    double width = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              thirdColorBlack,
              BlendMode.darken,
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          buildEllipse(
            sizeWidth: width * 0.5,
            sizeHeight: width * 0.6,
          ),
        ],
      ),
    );
  }
}
