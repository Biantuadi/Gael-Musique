import 'package:Gael/data/providers/theme_provider.dart';
import 'package:Gael/utils/routes/main_routes.dart';
import 'package:Gael/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
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
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
          theme: ThemeData(
            primaryColor: ThemeVariables.primaryColor,
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
          home: const SplashScreen(),
        );
      }
    );
  }
}
