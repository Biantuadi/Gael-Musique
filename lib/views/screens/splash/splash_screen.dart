import 'package:Gael/data/providers/auth_provider.dart';
import 'package:Gael/data/providers/chat_provider.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/providers/song_provider.dart';
import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/data/providers/events_provider.dart';
import 'package:Gael/data/providers/streaming_provider.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/assets.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:Gael/views/components/bottom_sheet.dart';
import 'package:Gael/views/components/custom_snackbar.dart';
import 'package:Gael/views/screens/not_internet_page.dart';
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


  String loadingText = "Chargement...";
  Connectivity connectivity = Connectivity();

  Future noInternetCallBacks()async{
    showCustomBottomSheet(
        context: context,
        content: NoInternetWidget(
          voidCallback: () async{
            await Provider.of<SongProvider>(context, listen: false).getSongsFromDB().then(
                    (value)async{
                  await Provider.of<SongProvider>(context, listen: false).getAlbumsFromDB().then((value)async{
                  });
                }
            );
            await Provider.of<EventsProvider>(context, listen: false).getEventsFromDB();
            await Provider.of<ChatProvider>(context, listen: false).getUsersFromDB();
            await Provider.of<ChatProvider>(context, listen: false).getUsersFromDB();
            Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
          },
        ));
  }

  Future internetCallBacks()async{
    await Provider.of<SongProvider>(context, listen: false).getSongsFromApi().then(
            (value)async{
          await Provider.of<SongProvider>(context, listen: false).getAlbums().then((value)async{
          });
        }
    );
    await Provider.of<EventsProvider>(context, listen: false).getEventsFromAPi();
    await Provider.of<ChatProvider>(context, listen: false).getUsersFromApi();
    await Provider.of<StreamingProvider>(context, listen: false).getStreaming();
    await Provider.of<ChatProvider>(context, listen: false).getUsersFromApi();
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
  void initSocket(){
    Provider.of<SocketProvider>(context, listen: false).initSocket(
      successCallback: (){
      },
      errorCallBack: (error){
      },
      connectErrorCallBack: (error){},
      disconnectCallBack: () {  },
    );
  }



  void _route(){

    Provider.of<ThemeProvider>(context, listen: false).getTheme();

    Provider.of<SplashProvider>(context, listen: false).initConfig(
        successCallback: () async {
          await Provider.of<AuthProvider>(context, listen: false).getUserVars();
          if(
          Provider.of<SplashProvider>(context, listen: false).userToken != null
              && Provider.of<SplashProvider>(context, listen: false).tokenIsValid == true){
            route = Routes.mainScreen;
            if(Provider.of<SplashProvider>(context, listen: false).isOfflineMode){
              await noInternetCallBacks();
            }else{
                 connectivity.checkConnectivity().then((value)async{
                  if(value.isNotEmpty){
                    if(value.contains(ConnectivityResult.ethernet) || value.contains(ConnectivityResult.mobile) || value.contains(ConnectivityResult.wifi) ){
                      await internetCallBacks();
                    }else{
                      await noInternetCallBacks();
                    }
                  }
                });
            }

          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(text: "Informations non retrouvées, veillez vous connecter!", context: context, bgColor: Colors.red)
            );
            Navigator.pushNamed(context, Routes.landingScreen);
          }

        },
        errorCallback: (){
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.landingScreen, (route) => false);
        }
    );
  }

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
                            Text(loadingText, style: Theme.of(context).textTheme.bodySmall,),
                            SizedBox(height: Dimensions.spacingSizeDefault,),
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
