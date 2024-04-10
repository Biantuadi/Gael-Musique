import 'package:Gael/data/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider with ChangeNotifier{
  NotificationRepository notificationRepository;
  NotificationProvider({required this.notificationRepository});

  int notificationTotalItems =0;
  int notificationCurrentPage =0;
  int notificationTotalPages =0;

  incrementCurrentPage(){
    if(notificationCurrentPage < notificationTotalPages){
      notificationCurrentPage++;
    }
  }

}