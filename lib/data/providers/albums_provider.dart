import 'package:Gael/data/models/album_model.dart';
import 'package:flutter/foundation.dart';
import 'package:Gael/data/repositories/albums_repository.dart';

class AlbumsProvider with ChangeNotifier {
  AlbumsRepository albumsRepository;
  AlbumsProvider({required this.albumsRepository});

  List<Album> allAlbums = [];
  List<Album>? albumsToShow;

 Future<List<Album>> getAlbums() async {
    allAlbums = await albumsRepository.getAlbums();
    albumsToShow = allAlbums;

    print('allAlbums: $allAlbums');
    notifyListeners();

    return allAlbums; // Return the list of albums
  }
  }
