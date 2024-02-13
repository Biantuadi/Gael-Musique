import 'dart:async';
import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _route();
  }


  void _route(){
    String route = Routes.landingScreen;
    Provider.of<ThemeProvider>(context, listen: false).getTheme();
    Provider.of<SplashProvider>(context, listen: false).initConfig(
        successCallback: () async {
          await Provider.of<AuthProvider>(context, listen: false).getUserVars();
          if(Provider.of<SplashProvider>(context, listen: false).userToken != null ){
            route = Routes.mainScreen;
            await Provider.of<SongProvider>(context, listen: false).getSongs();
            await Provider.of<SongProvider>(context, listen: false).getAlbums();
          }
          Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
        },
        errorCallback: (){
          //
        }
    );}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.height,
        child: Consumer<SplashProvider>(
            builder: (BuildContext context, provider, Widget? child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Assets.splashBgJPG,
                width: size.width,
                height: size.height,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: ThemeVariables.linearGradient),
                ),
              ),
              Opacity(
                opacity: 0.6,
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: size.height,
                width: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      Provider.of<ThemeProvider>(context, listen: true).isDark
                          ? Assets.logoPNG
                          : Assets.logoPNG,
                      width: size.width / 3,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        bottom: 30,
                        child: Column(
                          children: [
                            Provider.of<SplashProvider>(context,
                                listen: true)
                                .isFirstTime
                                ? Container(
                                padding: EdgeInsets.only(
                                    bottom: Dimensions.iconSizeSmall),
                                child: Text(
                                  "Initialisation...",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ))
                                : const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                            const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
