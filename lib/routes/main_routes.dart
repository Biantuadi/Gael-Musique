import 'package:Gael/screens/home/home_screen.dart';
import 'package:Gael/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = "SPLASH-SCREEN";
  static const String homeScreen = "HOME-SCREEN";
  static const String loginScreen = "LOGIN-SCREEN";
  static const String registerScreen = "REGISTER-SCREEN";
  static const String landingScreen = "LANDING-SCREEN";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      // case splashScreen:
      // return MaterialPageRoute(builder: (_) => const SplashScreen() );
      case landingScreen:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      // case registerScreen:
      //   return MaterialPageRoute(builder: (_) => const RegisterScreen());
      // case loginScreen:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _NotFoundRoute();
    }
  }

  static Route<dynamic> _NotFoundRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Lien introuvable")),
        body: const Center(child: Text("Lien introuvable")),
      );
    });
  }
}
