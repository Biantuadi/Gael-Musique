import 'package:Gael/data/api/client/dio_client.dart';
import 'package:Gael/data/data_base/database_client.dart';
// import 'package:Gael/data/models/chat_model.dart';
import 'package:Gael/data/models/event_model.dart';
import 'package:Gael/data/models/event_ticket_model.dart';
import 'package:Gael/utils/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsRepository {
  SharedPreferences sharedPreferences;
  DioClient dioClient;
  EventsRepository({required this.sharedPreferences, required this.dioClient});


  Future<Response> getEvents()async{
    Response response = await dioClient.get(AppConfig.eventsUrl);
    return response;
  }
  Future<Response> getTickets()async{
    Response response = await dioClient.get(AppConfig.userTicketsUrl);
    return response;
  }

  Future<String?> getUserID()async{
    return  sharedPreferences.getString(AppConfig.sharedUserID);
  }

  Future<List<Event>> getEventsFromDb() async{
    // ignore: unused_local_variable
    String userId = await getUserID() ?? '';
    List<Event> events = [];
    var db = DatabaseHelper.instance;
    await db.fetchEvents().then(
            (value){
          events = value;
        }
    );
    return events;
  }

  Future<Event?> getOneEventFromDB({required String eventID})async{
    var db = DatabaseHelper.instance;
    await db.fetchEvent(eventID).then((value)=>value);
    return null;
  }

  upsertEvent({required Event event})async{
    var db = DatabaseHelper.instance;
    db.upsertEvent(event);
  }

  deleteEvent({required String id}){
    var db = DatabaseHelper.instance;
    db.deleteEvent(id);
  }


  Future<List<EventTicket>> getEventsTicketsFromDb() async{
    String userId = await getUserID() ?? '';
    List<EventTicket> tickets = [];
    var db = DatabaseHelper.instance;
    await db.fetchEventTickets(userId).then(
            (value){
              tickets = value;
        }
    );
    return tickets;
  }

  Future<EventTicket?> getOneEventTicketFromDB()async{
    var db = DatabaseHelper.instance;
    String userId = await getUserID() ?? '';
    await db.fetchEventTicket(userId: userId).then((value)=>value);
    return null;
  }

  Future<EventTicket?> getOneUserEventTicketFromDB(String eventID)async{
    var db = DatabaseHelper.instance;
    String userId = await getUserID() ?? '';
    await db.fetchEventTicket(userId: userId, eventId: eventID).then((value)=>value);
    return null;
  }

  upsertEventTicket({required EventTicket eventTicket})async{
    var db = DatabaseHelper.instance;
    db.upsertEventTicket(eventTicket);
  }

  deleteEventTicket({required String id}){
    var db = DatabaseHelper.instance;
    db.deleteEventTicket(id);
  }

}