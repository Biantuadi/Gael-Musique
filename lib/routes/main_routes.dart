import 'package:Gael/screens/chat/chat_creen.dart';
import 'package:Gael/screens/favorite/favorite_sreen.dart';
import 'package:Gael/screens/home/home_screen.dart';
import 'package:Gael/screens/landing/landing_screen.dart';
import 'package:Gael/screens/profile/profile_screen.dart';
import 'package:Gael/screens/radio/radio_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  // loading screen
  static const String splashScreen = "SPLASH-SCREEN";

  // Auth
  static const String loginScreen = "LOGIN-SCREEN";
  static const String registerScreen = "REGISTER-SCREEN";

  // App
  static const String landingScreen = "LANDING-SCREEN";
  static const String homeScreen = "HOME-SCREEN";
  static const String chatScreen = "CHAT-SCREEN";
  static const String radioScreen = "RADIO-SCREEN";
  static const String favoritesScreen = "FAVORITES-SCREEN";
  static const String profileScreen = "PROFILE-SCREEN";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingScreen:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case radioScreen:
        return MaterialPageRoute(builder: (_) => const RadioScreen());
      case favoritesScreen:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
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
