import 'package:Gael/data/repositories/favorite_repository.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier{
  FavoriteRepository favoriteRepository;
  FavoriteProvider({required this.favoriteRepository});
}