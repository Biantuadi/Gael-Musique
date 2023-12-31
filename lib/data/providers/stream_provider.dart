import 'package:Gael/data/repositories/stream_repository.dart';
import 'package:flutter/foundation.dart';


/// I CALLED IT STREAMS TO MAKE DIFFERENCE WITH STREAMPROVIDER PACKAGE DEFINED IN FLUTTER

class StreamsProvider with ChangeNotifier{
  StreamRepository streamRepository;
  StreamsProvider({required this.streamRepository});
}