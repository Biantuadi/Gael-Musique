import 'package:Gael/data/models/song_model.dart';

class Album{
  late String id;
  late String title;
  late String subtitle;
  late String artist;
  late int year;
  late String? imgAlbum;
  late List<Song> songs;
  late List<String> songsIds;
  late List<dynamic> userBuy;
  late DateTime createdAt;
  Album({
    required this.title,
    required this.subtitle,
    required this.id,
    required this.userBuy,
    required this.songs,
    required this.createdAt,
    required this.year,
    required this.artist,
    required this.imgAlbum,
    required this.songsIds
  });

  Album.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    title = json["title"];
    subtitle = json["subtitle"];
    createdAt = DateTime.parse(json["createdAt"]);
    imgAlbum = json["imgAlbum"];
    if(json["songs"] != null){
      songsIds =[];
      json["songs"].forEach((songId){
        songsIds.add(songId);
      });
    }
    userBuy = json["usersBuy"];
    year = json["year"];
    artist = json["artist"];
    songs = [];

  }
  getSongsFromIds({required List<Song> allSongs}){
    songs = [];
    print("LES SONGS NBR : ${allSongs.length}");
    songsIds.forEach((id) {
      allSongs.forEach((song) {
        if(song.id == id) {
          songs.add(song);
        }
      });


      //Song? sng = allSongs.singleWhere((song) => song.id == id);
      //if (sng != null) songs.add(sng);
    });
  }



}