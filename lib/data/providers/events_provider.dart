import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/models/event_ticket_model.dart';
import 'package:Gael/data/providers/socket_provider.dart';
import 'package:Gael/data/repositories/events_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier{
  EventsRepository eventsRepository;
  SocketProvider socketProvider;
  EventsProvider({required this.eventsRepository, required this.socketProvider});

  List<Event>? events;
  List<EventTicket>? tickets;
  int eventTotalItems =0;
  int eventCurrentPage =0;
  int eventTotalPages =0;

  int ticketTotalItems =0;
  int ticketCurrentPage =0;
  int ticketTotalPages =0;

  incrementCurrentPage(){
    if(eventCurrentPage < eventTotalPages){
      eventCurrentPage++;
      getEventsFromAPi();
    }
  }
  getEventsFromAPi()async{
    Response response = await eventsRepository.getEvents();
    if(response.statusCode == 200){
      List data = response.data["items"];
      events = events??[];
      eventTotalItems = response.data["totalItems"];
      eventCurrentPage = response.data["currentPage"];
      eventTotalPages = response.data["totalPages"];
      data.forEach((event)async {
        events!.add(Event.fromJson(json : event));
        await eventsRepository.upsertEvent(event: (Event.fromJson(json : event)));
        notifyListeners();
      });
    }
  }
getEventsFromDB()async{
  events = await eventsRepository.getEventsFromDb();
  notifyListeners();
}

  getTicketsFromDB()async{
    tickets = await eventsRepository.getEventsTicketsFromDb();
    notifyListeners();
  }

  getTicketsFromAPi()async{
    Response response = await eventsRepository.getTickets();
    if(response.statusCode == 200){
      List data = response.data["items"];
      tickets = tickets?? [];
      ticketTotalItems = response.data["totalItems"];
      ticketCurrentPage = response.data["currentPage"];
      ticketTotalPages = response.data["totalPages"];
      data.forEach((ticket) {
        tickets!.add(EventTicket.fromJson(json : ticket));
        eventsRepository.upsertEventTicket(eventTicket: EventTicket.fromJson(json : ticket));
        notifyListeners();
      });
    }
  }


}