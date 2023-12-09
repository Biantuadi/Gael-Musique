import 'package:Gael/data/providers/splash_provider.dart';
import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
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
              primaryColor: ThemeVariables.primaryColor,
              colorScheme: const ColorScheme(
                  background: Colors.white,
                  brightness: Brightness.dark,
                  primary: ThemeVariables.primaryColor,
                  onPrimary: ThemeVariables.primaryColor,
                  secondary: ThemeVariables.secondaryColor,
                  onSecondary: ThemeVariables.secondaryColor,
                  error: Colors.red,
                  onError: Colors.redAccent,
                  onBackground: ThemeVariables.primaryColor,
                  surface: ThemeVariables.primaryColor,
                  onSurface: ThemeVariables.primaryColor,

              ),
              scaffoldBackgroundColor: ThemeVariables.thirdColorBlack,
              textTheme: TextTheme(
                titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 35),
                titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 25),
                titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15),
                bodyLarge: GoogleFonts.poppins(fontSize: 30),
                bodyMedium: GoogleFonts.poppins(fontSize: 15),
                bodySmall: GoogleFonts.poppins(fontSize: 12),
              ),
              iconTheme: IconThemeData(
                size: provider.iconSizeDefault,
                color: isDark? Colors.white : Colors.black,
              )
          ),
            home: FutureBuilder(
                future:provider.themeMode == ThemeMode.system ? syncWithOs(context) : future(),
                builder: (context, snapshot) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: SystemUiOverlayStyle(
                        statusBarColor : Colors.transparent,
                        statusBarBrightness: isDark? Brightness.light: Brightness.dark,
                        statusBarIconBrightness: isDark? Brightness.light : Brightness.dark,
                        systemNavigationBarColor: isDark? Colors.black :  Colors.transparent,
                        systemNavigationBarContrastEnforced: true,
                        systemNavigationBarIconBrightness:isDark?Brightness.light : Brightness.dark,
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarDividerColor: Colors.transparent,
                      ),
                      child: const SplashScreen()
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
