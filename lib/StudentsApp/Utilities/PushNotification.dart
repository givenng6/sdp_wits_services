import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification{
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    }) async => _notification.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload
  );

  static Future _notificationDetails() async{
      return NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max
        ),

      );
  }
}