// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:Gael/data/models/album_model.dart';
import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/models/event_ticket_model.dart';
import 'package:Gael/data/models/message_model.dart';
import 'package:Gael/data/models/song_model.dart';
import 'package:Gael/data/models/streaming_model.dart';
import 'package:Gael/data/models/user_model.dart';
import 'package:Gael/utils/database_queries.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static  Database? _database;

  Future<Database> get database async {
    if (_database  != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database and creates it if it doesn't exist
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // SQL code to create  table
    await db.execute(DatabaseQueries.createAlbumTable());
    await db.execute(DatabaseQueries.createSongTable());
    await db.execute(DatabaseQueries.createUserTable());
    await db.execute(DatabaseQueries.createEventTable());
    await db.execute(DatabaseQueries.createEventTicketTable());
    await db.execute(DatabaseQueries.createChatTable());
    await db.execute(DatabaseQueries.createMessageTable());
    await db.execute(DatabaseQueries.createStreamingTable());
  }

  // Inserting and updating a song
  Future<Song> upsertSong(Song song) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM song WHERE _id = ?", ['${song.id}']));
    if (count == 0) {
      await db.insert("song", song.toJson());
    } else {
      await db.update("song", song.toJson(), where: "_id = ?", whereArgs: ['${song.id}']);
    }
    return song;
  }
  Future<Streaming> upsertStreaming(Streaming streaming) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM streaming WHERE _id = ?", ['${streaming.id}']));
    if (count == 0) {
      await db.insert("streaming", streaming.toJson());
    } else {
      await db.update("streaming", streaming.toJson(), where: "_id = ?", whereArgs: ['${streaming.id}']);
    }
    return streaming;
  }

  // Inserting and updating an album
  Future<Album> upsertAlbum(Album album) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM album WHERE _id = ?", [album.id]));
    if (count == 0) {
      await db.insert("album", album.toJson());
    } else {
      await db.update("album", album.toJson(), where: "_id = ?", whereArgs: ['${album.id}']);
    }
    return album;
  }

  // to insert or update USER
  Future<User> upsertUser(User user) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM user WHERE _id = ?", ['${user.id}']));
    if (count == 0) {
      await db.insert("user", user.toJson());
    } else {
      await db.update("user", user.toJson(), where: "_id = ?", whereArgs: ['${user.id}']);
    }
    return user;
  }

  // to insert or update CHAT
  Future<Chat> upsertChat(Chat chat) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM chat WHERE _id = ?", ['${chat.id}']));
    if (count == 0) {
      chat.createdAt = DateTime.now();
      await db.insert("chat", chat.toJson());
    } else {
      chat.updatedAt = DateTime.now();
      await db.update("chat", chat.toJson(), where: "_id = ?", whereArgs: ['${chat.id}']);
    }
    return chat;
  }


  // to insert or update MESSAGE
  Future<Message> upsertMessage(Message message) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM message WHERE _id = ?", ['${message.id}']));
    if (count == 0) {
      await db.insert("message", message.toJson());
    } else {
      await db.update("message", message.toJson(), where: "_id = ?", whereArgs: ['${message.id}']);
    }
    return message;
  }

  // to insert or update EVENT
  Future<Event> upsertEvent(Event event) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM message WHERE _id = ?", ['${event.id}']));
    if (count == 0) {
      await db.insert("event", event.toJson());
    } else {
      await db.update("event", event.toJson(), where: "_id = ?", whereArgs: ['${event.id}']);
    }
    return event;
  }

  // to insert or update EVENT TICKET
  Future<EventTicket> upsertEventTicket(EventTicket ticket) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM eventTicket WHERE _id = ?", ['${ticket.id}']));
    if (count == 0) {
      await db.insert("eventTicket", ticket.toJson());
    } else {
      await db.update("eventTicket", ticket.toJson(), where: "_id = ?", whereArgs: ['${ticket.id}']);
    }
    return ticket;
  }

  // GET A SONG
  Future<Song?> fetchSong(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("song", where: "_id = ?", whereArgs: ['$id']);
    if(results.isNotEmpty){
      var result = results[0];
      return Song.fromJson(result);
    }
    return null;
  }
  // GET A STREAMING
  Future<Streaming?> fetchStreaming(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("streaming", where: "_id = ?", whereArgs: ["$id"]);
    if(results.isNotEmpty){
      var result = results[0];
      return Streaming.fromJson(result);
    }
    return null;
  }

  // GET USER
  Future<User?> fetchUser(String id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> results = await db.query("user", where: "_id = ?", whereArgs: ['$id']);

    if(results.isNotEmpty){
      User user =  User.fromJson(results[0]);
      return user;
    }
    return null;
  }

  // GET ALBUM
  Future<Album?> fetchAlbum(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("album", where: "_id = ?", whereArgs: ["$id"]);
    if(results.isNotEmpty){
      var result = results[0];
      List<Song> songs = await fetchAlbumSongs(result["_id"]);
      Album album = Album.fromJson(json: result);
      album.songs = songs;
      return album;
    }
    return null;
  }

  // GET CHAT
  Future<Chat?> fetchChat(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("chat", where: "_id = ?", whereArgs: ["$id"]);
    
    if(results.isNotEmpty){
      Chat chat = Chat.fromJson(json: results[0]);
      chat.user1 = await fetchUser(chat.user1Id);
      chat.user2 = await fetchUser(chat.user2Id);
      chat.messages = await fetchMessages(chat.id);
      print("USER 1 *** ${chat.user1}");
      print("USER 2 *** ${chat.user2}");
      print("MSG *** ${chat.messages}");
      return chat;
    }
    
    return null;
  }

  // GET MESSAGE
  Future<Message?> fetchMessage(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("message", where: "_id = ?", whereArgs: ["$id"]);
    if(results.isNotEmpty){
      Message message = Message.fromJson(json:results[0]);
      message.user = (await fetchUser(message.id))!;
      return message;
    }
    return null;
  }

  // EVENT

  Future<Event?> fetchEvent(String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("event", where: "_id = ?", whereArgs: ["$id"]);
    if(results.isNotEmpty){
      return Event.fromJson(json: results[0]);
    }
    return null;
  }

  Future<EventTicket?> fetchEventTicket({required String userId, String? eventId}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = [];
    String query = "SELECT * FROM eventTicket WHERE userId=$userId ";

    if(eventId != null){
      query += "AND eventId=$eventId";
    }

    results = await db.rawQuery(query);
    if(results.isNotEmpty){
      var ticket = results[0];
      ticket["userId"] = await fetchUser(ticket["userId"]);
      return EventTicket.fromJson(json:ticket);
    }
    return null;
  }
  Future<List<Song>> fetchSongs() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("song");
    List<Song> songs = [];
    for (var result in results) {
      Song song = Song.fromJson(result);
      songs.add(song);
    }
    return songs;
  }
  Future<List<Streaming>> fetchStreamings() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("streaming");
    List<Streaming> streamings = [];
    for (var result in results) {
      Streaming streaming = Streaming.fromJson(result);
      streamings.add(streaming);
    }
    return streamings;
  }
  Future<List<Song>> fetchAlbumSongs(String albumId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("song" ,  where: "albumId = ?", whereArgs: ["$albumId"]);
    List<Song> songs = [];
    for (var result in results) {
      Song song = Song.fromJson(result);
      songs.add(song);
    }
    return songs;
  }
  Future<List<Album>> fetchAlbums() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("album");
    List<Album> albums = [];
    for (var result in results) {
      List<Song> songs = await fetchAlbumSongs(result["_id"]);
      Album album = Album.fromJson(json: result);
      album.songs = songs;
      albums.add(album);
    }
    return albums;
  }
  Future<List<User>> fetchUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("user");
    List<User> users = [];
    for (var result in results) {
      users.add(User.fromJson(result));
    }
    return users;
  }
  Future<List<Chat>> fetchChats(String userId) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> results = await db.rawQuery("SELECT * FROM chat WHERE user1='$userId' OR user2='$userId'");
    List<Chat> chats = [];
    for (var result in results) {
      Chat chat = Chat.fromJson(json: result);
      chat.user1 = await fetchUser(chat.user1Id);
      print("USZR 1 : ${chat.user1!.toJson()}");
      chat.user2 = await fetchUser(chat.user2Id);
      chat.messages = await fetchMessages(chat.id);
      chats.add(chat);
    }
    return chats;
  }
  Future<List<Message>> fetchMessages(String chatId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.rawQuery("SELECT * FROM message WHERE chatId='$chatId'");
    List<Message> messages = [];
    for (var result in results) {
      result["user"] = await fetchUser(result["user"]);
      messages.add(Message.fromJson(json: result));
    }
    return messages;
  }
  Future<List<Event>> fetchEvents() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.rawQuery("SELECT * FROM event");
    List<Event> events = [];
    for (var result in results) {
      events.add(Event.fromJson(json: result));
    }
    return events;
  }
  Future<List<EventTicket>> fetchEventTickets(String userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.rawQuery("SELECT * FROM eventTicket WHERE user='$userId'");
    List<EventTicket> tickets = [];
    for (var result in results) {
      result["userId"] = await fetchUser(result["userId"]);
      tickets.add(EventTicket.fromJson(json :result));
    }
    return tickets;
  }

  Future<void> deleteSong(String id) async {
    Database db = await instance.database;
    await db.delete("song", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteStreaming(String id) async {
    Database db = await instance.database;
    await db.delete("streaming", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteAlbum(String id) async {
    Database db = await instance.database;
    await db.delete("album", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteUser(String id) async {
    Database db = await instance.database;
    await db.delete("user", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteChat(String id) async {
    Database db = await instance.database;
    await db.delete("chat", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteMessage(String id) async {
    Database db = await instance.database;
    await db.delete("message", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteEvent(String id) async {
    Database db = await instance.database;
    await db.delete("event", where: "id = ?", whereArgs: ["$id"]);
  }
  Future<void> deleteEventTicket(String id) async {
    Database db = await instance.database;
    await db.delete("eventTicket", where: "id = ?", whereArgs: ["$id"]);
  }

}
