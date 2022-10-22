import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification{

  final _notification = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications()async{
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@drawable/ic_stat_workspaces_filled');
    
    DarwinInitializationSettings darwinInitializationSettings =  DarwinInitializationSettings(
      requestAlertPermission:  true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification
    );

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings
    );
    
    await _notification.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
            "channel_id",
            "channel_name",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true
          );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );
  }

  Future<void> showNotification({required int id, required String title, required String body}) async{
    final details = await _notificationDetails();
    await _notification.show(id, title, body, details);
  }

  void _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
  print('id $id');
  }
}