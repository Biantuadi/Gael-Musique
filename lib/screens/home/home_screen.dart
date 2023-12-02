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
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          // navigation bar
          Container(
            height: 100,
            // decoration: const BoxDecoration(
            //   color: Colors.white,
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black12,
            //       blurRadius: 5,
            //       offset: Offset(0, 0),
            //     )
            //   ],
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // logo
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    'assets/logo/logo.png',
                    height: 50,
                  ),
                ),
                // search bar
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child:
                      // icon notification
                      Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        onPressed: () {},
                      ),
                      // icon profile
                      IconButton(
                        icon: const Icon(Icons.person_outline),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
