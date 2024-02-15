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
import 'data/providers/events_provider.dart';
import 'data/providers/favorite_provider.dart';
import 'data/providers/notification_provider.dart';
import 'data/providers/song_provider.dart';
import 'data/providers/streaming_provider.dart';
import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SongProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<FavoriteProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<StreamingProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<EventsProvider>()),
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
        theme: ThemeData(
            primaryColor: Colors.white,
            colorScheme: const ColorScheme(
              background: Colors.black,
              brightness: Brightness.dark,
              primary: Colors.transparent,
              onPrimary: Colors.white, // ThemeVariables.primaryColor,
              secondary: ThemeVariables.thirdColorBlack,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.redAccent,
              onBackground: Colors.white, //ThemeVariables.primaryColor,
              surface: ThemeVariables.thirdColorBlack,
              onSurface: Colors.white,
            ),
            scaffoldBackgroundColor: ThemeVariables.thirdColorBlack,
            dialogBackgroundColor: ThemeVariables.thirdColorBlack,
            // ignore: deprecated_member_use
            backgroundColor: ThemeVariables.thirdColorBlack,
            textTheme: TextTheme(
              titleLarge: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  color: Colors.white),
              titleMedium: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white),
              titleSmall: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white),
              bodyLarge: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  color: Colors.white),
              bodyMedium: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.white),
              bodySmall: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.white),
            ),
            iconTheme: IconThemeData(
              size: Dimensions.iconSizeDefault,
              color: isDark ? Colors.white : Colors.black,
            )),
        home: FutureBuilder(
            future: provider.themeMode == ThemeMode.system
                ? syncWithOs(context)
                : future(),
            builder: (context, snapshot) {
              return const AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: Colors.black,
                    systemNavigationBarContrastEnforced: true,
                    systemNavigationBarIconBrightness: Brightness.light,
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarDividerColor: Colors.transparent,
                  ),
                  child: SplashScreen(),
                  );
            }),
      );
    });
  }

  syncWithOs(context) {
    Provider.of<ThemeProvider>(context, listen: false).getTheme();
  }

  future() {
    //
  }
}
