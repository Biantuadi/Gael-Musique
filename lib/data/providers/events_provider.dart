import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/repositories/events_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier{
  EventsRepository eventsRepository;
  EventsProvider({required this.eventsRepository});

  List<Event>? events;

  getEvents()async{
    Response response = await eventsRepository.getEvents();
    print("LA RESPONSE CODE: ${response.statusCode}");
    if(response.statusCode == 200){
      List data = response.data;
      events = [];
      data.forEach((event) {
        events!.add(Event.fromJson(event));
      });
      notifyListeners();
    }
  }
}