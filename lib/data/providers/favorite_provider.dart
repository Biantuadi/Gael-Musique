import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/repositories/favorite_repository.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier{
  FavoriteRepository favoriteRepository;
  SocketProvider socketProvider;
  FavoriteProvider({required this.favoriteRepository, required this.socketProvider});
}