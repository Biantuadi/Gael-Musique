import 'package:Gael/data/repositories/song_repository.dart';
import 'package:flutter/foundation.dart';

class SongProvider with ChangeNotifier{
  SongRepository songRepository;
  SongProvider({required this.songRepository});
}