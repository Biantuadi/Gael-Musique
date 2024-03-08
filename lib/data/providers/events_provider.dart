import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/repositories/events_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier{
  EventsRepository eventsRepository;
  SocketProvider socketProvider;
  EventsProvider({required this.eventsRepository, required this.socketProvider});

  List<Event>? events;

  getEvents()async{
    Response response = await eventsRepository.getEvents();
    if(response.statusCode == 200){
      List data = response.data["items"];
      events = [];
      data.forEach((event) {
        events!.add(Event.fromJson(event));
      });
      notifyListeners();
    }
  }
}