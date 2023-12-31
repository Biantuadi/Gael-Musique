import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:Gael/utils/dimensions.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'data/providers/auth_provider.dart';
import 'data/providers/chat_provider.dart';
import 'data/providers/favorite_provider.dart';
import 'data/providers/notification_provider.dart';
import 'data/providers/song_provider.dart';
import 'data/providers/stream_provider.dart';
import 'di_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SongProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FavoriteProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<StreamsProvider>()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


   return Consumer<ThemeProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          bool isDark = provider.isDark;
          return MaterialApp(
            themeMode: provider.themeMode,
            title: AppConfig.APP_NAME,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generateRoute,
            theme:  ThemeData(
              primaryColor: Colors.white,
              colorScheme: const ColorScheme(
                  background: Colors.black,
                  brightness: Brightness.dark,
                  primary: ThemeVariables.primaryColor,
                  onPrimary:Colors.transparent ,// ThemeVariables.primaryColor,
                  secondary: ThemeVariables.secondaryColor,
                  onSecondary: ThemeVariables.secondaryColor,
                  error: Colors.red,
                  onError: Colors.redAccent,
                  onBackground:Colors.transparent ,//ThemeVariables.primaryColor,
                  surface: ThemeVariables.primaryColor,
                  onSurface: ThemeVariables.primaryColor,

              ),
              scaffoldBackgroundColor: ThemeVariables.thirdColorBlack,
              textTheme: TextTheme(
                titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 25),
                titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
                titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
                bodyLarge: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 25),
                bodyMedium: GoogleFonts.poppins(fontWeight: FontWeight.w300,fontSize: 14),
                bodySmall: GoogleFonts.poppins(fontWeight: FontWeight.w300,fontSize: 12),
              ),
              iconTheme: IconThemeData(
                size: Dimensions.iconSizeDefault,
                color: isDark? Colors.white : Colors.black,
              )
          ),
            home: FutureBuilder(
                future:provider.themeMode == ThemeMode.system ? syncWithOs(context) : future(),
                builder: (context, snapshot) {
                  return const AnnotatedRegion<SystemUiOverlayStyle>(
                      value: SystemUiOverlayStyle(
                        statusBarColor : Colors.transparent,
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness:  Brightness.light,
                        systemNavigationBarColor: Colors.black,
                        systemNavigationBarContrastEnforced: true,
                        systemNavigationBarIconBrightness:Brightness.light,
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarDividerColor: Colors.transparent,
                      ),
                      child: SplashScreen()
                  );
                }
            ),
          );
        });
  }
  syncWithOs(context){
    Provider.of<ThemeProvider>(context, listen: false).getTheme();
  }

  future(){
    //
  }

}
