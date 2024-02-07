import 'package:Gael/data/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider with ChangeNotifier{
  NotificationRepository notificationRepository;
  NotificationProvider({required this.notificationRepository});
}