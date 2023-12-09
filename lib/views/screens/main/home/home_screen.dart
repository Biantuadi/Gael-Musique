import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/views/components/layouts/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'components/home_card.dart';

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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return  Scaffold(
      body: Column(
        children: [
          const CustomHeader(
            showLogo: true,
            showAvatar: true,
          ),
          Padding(
            padding: EdgeInsets.all(themeProvider.spacingSizeDefault),
            child: Wrap(
              spacing: themeProvider.spacingSizeDefault/2,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom:themeProvider.spacingSizeDefault/2),
                  child: HomeCard(onTap: (){}, iconData: Iconsax.share, title: "Tredding & radios", width: (size.width/2) - 3* themeProvider.spacingSizeDefault/2, ),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom:themeProvider.spacingSizeDefault/2),
                  child: HomeCard(onTap: (){}, iconData: Iconsax.book, title: "Enseignements", width: (size.width/2) - 3* themeProvider.spacingSizeDefault/2, ),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom:themeProvider.spacingSizeDefault/2),
                  child: HomeCard(onTap: (){}, iconData: Iconsax.music, title: "Album", width: (size.width/2) - 3* themeProvider.spacingSizeDefault/2, ),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom:themeProvider.spacingSizeDefault/2),
                  child: HomeCard(onTap: (){}, iconData: Iconsax.calendar, title: "Evenements", width: (size.width/2) - 3* themeProvider.spacingSizeDefault/2, ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
