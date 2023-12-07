import 'dart:async';

import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }

}
class SplashScreenState extends State<SplashScreen>{
 // Connectivity  connectivity  = Connectivity();
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void>getSongs()async{

  }
  void _route() {
    Provider.of<ThemeProvider>(context, listen: false).getTheme();
    Provider.of<ThemeProvider>(context, listen: false).getSizes();
    Provider.of<SplashProvider>(context, listen: false).initConfig(context).then(
            (value){
          if(value == true){

          }
        }
    );

    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamedAndRemoveUntil(context, Routes.landingScreen, (route) => false);
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.height,
        child: Stack(
          children: [
            Image.asset(Assets.bgWelcomeWEBP, width: size.width, height: size.height, fit: BoxFit.cover,),
            Container(
              decoration: const BoxDecoration(
                gradient: ThemeVariables.linearGradient
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  Provider.of<ThemeProvider>(context, listen: true).isDark ?
                  Assets.logoPNG : Assets.logoPNG,
                  width: size.width/3,
                  fit: BoxFit.cover,
                ),

                Positioned(
                    bottom: 30,
                    child: Column(
                      children: [
                        Provider.of<SplashProvider>(context, listen: true).isFirstTime?
                        Container(
                            padding: EdgeInsets.only(bottom: Provider.of<ThemeProvider>(context, listen: false).iconSizeSmall),
                            child: Text("Initialisation...", style: Theme.of(context).textTheme.bodySmall,)): const SizedBox(height: 0, width: 0,),
                        CircularProgressIndicator(
                          color: Provider.of<ThemeProvider>(context, listen: false).isDark ? Colors.white : Colors.black,
                          strokeWidth: 1,
                        ),
                      ],
                    ))

              ],
            ),
          ],
        ),
      ),
    );
  }
}