// ignore_for_file: non_constant_identifier_names
import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/views/screens/screens.dart';
import 'package:flutter/material.dart';

class Routes {
  // loading screen
  static const String splashScreen = "SPLASH-SCREEN";

  // Auth
  static const String loginScreen = "LOGIN-SCREEN";
  static const String registerScreen = "REGISTER-SCREEN";
  static const String registerInfoConfigScreen = "REGISTER-INFO-SCREEN";
  static const String registerPasswordConfigScreen = "REGISTER-PASSWORD-SCREEN";
  static const String registerProfileConfigScreen = "REGISTER-PROFILE-SCREEN";

  // App
  static const String mainScreen = "MAIN-SCREEN";
  static const String landingScreen = "LANDING-SCREEN";
  static const String homeScreen = "HOME-SCREEN";
  static const String chatListScreen = "CHAT-LIST-SCREEN";
  static const String chatDetailScreen = "CHAT-DETAIL-SCREEN";

  static const String radioScreen = "RADIO-SCREEN";
  static const String streamingDetailsScreen = "STREAMING-DETAILS-SCREEN";
  static const String favoritesScreen = "FAVORITES-SCREEN";
  static const String profileScreen = "PROFILE-SCREEN";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case landingScreen:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) =>  const MainScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) =>   const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) =>  const RegisterScreen());
      case registerInfoConfigScreen:
        return MaterialPageRoute(builder: (_) =>  const RegisterConfigScreen());
      case registerPasswordConfigScreen:
        return MaterialPageRoute(builder: (_) =>  const PasswordConfigScreen());
      case registerProfileConfigScreen:
        return MaterialPageRoute(builder: (_) =>  const ProfileConfigScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case chatListScreen:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case chatDetailScreen:
        return MaterialPageRoute(builder: (_) => const ChatDetailScreen());
      case radioScreen:
        return MaterialPageRoute(builder: (_) => const StreamingScreen());
      case streamingDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  StreamingDetailsScreen(streaming: arguments as Streaming,));
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
