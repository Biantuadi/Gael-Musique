// ignore_for_file: non_constant_identifier_names
import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/models/song_model.dart';
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
  static const String noInternetScreen = "NO-INTERNET-SCREEN";

  static const String radioScreen = "RADIO-SCREEN";
  static const String streamingDetailsScreen = "STREAMING-DETAILS-SCREEN";
  static const String favoritesScreen = "FAVORITES-SCREEN";

  // ALBUMS
  static const String albumScreen = "ALBUM-SCREEN";
  static const String albumSongsScreen = "ALBUM-SONGS-SCREEN";
  static const String songDetailsScreen = "SONGS-DET-SCREEN";

  //PROFILE
  static const String profileScreen = "PROFILE-SCREEN";
  static const String aboutScreen = "ABOUT-SCREEN";
  static const String coursesScreen = "COURSES-SCREEN";
  static const String userEventScreen = "USER-PROFILE-SCREEN";
  static const String paymentScreen = "PAYMENT-SCREEN";
  static const String settingsScreen = "SETTINGS-SCREEN";
  static const String favoriteScreen = "FAVORITE-SCREEN";
  static const String infoUpdateScreen = "INFO-UPDATE-SCREEN";
  static const String passwordUpdateScreen = "PASSWORD-UPDATE-SCREEN";

  //EVENT
  static const String eventScreen = "EVENT-SCREEN";
  static const String eventDetailsScreen = "EVENT-DETAILS-SCREEN";

  // PAYMENTS

  static const String paymentsScreen = "PAYMENT-SCREEN";
  static const String paymentDetailsScreen = "PAYMENT-DETAILS";

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
        return MaterialPageRoute(builder: (_) =>  StreamingDetailsScreen());
      case favoritesScreen:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case aboutScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case coursesScreen:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
      case userEventScreen:
        return MaterialPageRoute(builder: (_) => const UserEventScreen());
      case favoriteScreen:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case infoUpdateScreen:
        return MaterialPageRoute(builder: (_) => const InfoUpdateScreen());
      case passwordUpdateScreen:
        return MaterialPageRoute(builder: (_) => const PasswordUpdateScreen());
      case albumScreen:
        return MaterialPageRoute(builder: (_) => const AlbumScreen());
      case albumSongsScreen:
        return MaterialPageRoute(builder: (_) =>  AlbumSongsScreen(album: arguments as Album,));
      case songDetailsScreen:
        return MaterialPageRoute(builder: (_) => const SongDetailsScreen());
      case eventScreen:
        return MaterialPageRoute(builder: (_) =>  const EventsScreen());
      case noInternetScreen:
        return MaterialPageRoute(builder: (_) =>  const NoInternetScreen());
      case paymentScreen:
        return MaterialPageRoute(builder: (_) =>  const PaymentScreen());
      case paymentDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  const PaymentDetailsScreen());
      case eventDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  EventDetailsScreen(event: arguments as Event,));
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
