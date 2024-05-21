// ignore_for_file: use_build_context_synchronously

import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/config_provider.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/custom_snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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

  String route = Routes.landingScreen;

  @override
  void initState() {
    super.initState();
    _route();
    initSocket();
  }


  Connectivity connectivity = Connectivity();



  void initSocket(){
    Provider.of<SocketProvider>(context, listen: false).initSocket(
      successCallback: (){

          ScaffoldMessenger.of(context).showSnackBar(
              customSnack(text: "Connexion établie!", context: context, bgColor: Colors.green)
          );
      },
      errorCallBack: (error){
        ScaffoldMessenger.of(context).showSnackBar(
          customSnack(text: "Une erreur s'est produite lors de la connexion au serveur", context: context, bgColor: Colors.red)
        );
      },
      connectErrorCallBack: (error){

        ScaffoldMessenger.of(context).showSnackBar(
            customSnack(text: "Vous avez été deconnecté (${error.toString()})", context: context, bgColor: Colors.orangeAccent)
        );
      },
      disconnectCallBack: () {  },
      userIsAuthenticated: Provider.of<AuthProvider>(context, listen: false).userIsAuthenticated,
    );
  }

  void _route() async{
    await Provider.of<ThemeProvider>(context, listen: false).getTheme();
    await Provider.of<AuthProvider>(context, listen: false).getUserVars();
      if(!Provider.of<ConfigProvider>(context, listen: false).isFirstTime){
        Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
      }else {
        Provider.of<ConfigProvider>(context, listen: false).initConfig();
        Navigator.pushNamedAndRemoveUntil(context, Routes.landingScreen, (route) => false);
      }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.height,
        child: Consumer<ConfigProvider>(
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
                            Provider.of<ConfigProvider>(context,
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
                            SizedBox(height: Dimensions.spacingSizeExtraSmall,),
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
