import 'package:Gael/routes/main_routes.dart';
import 'package:Gael/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:Gael/utils/theme_variables.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundBlack,
        textTheme: TextTheme(
          titleLarge:
              GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 35),
          titleMedium:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 25),
          titleSmall:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15),
          bodyLarge: GoogleFonts.poppins(fontSize: 30),
          bodyMedium: GoogleFonts.poppins(fontSize: 15),
          bodySmall: GoogleFonts.poppins(fontSize: 12),
        ),
      ),
      home: const LandingScreen(),
    );
  }
}
