// firebase_initializer.dart
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

void setupFirebaseMessaging() {
  _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'hello',
      channelDescription: 'hello testing',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // Display the notification
    FlutterLocalNotificationsPlugin().show(
      0, // Unique ID for this notification
      notification!.title, // Notification title
      notification.body, // Notification body
      platformChannelSpecifics,
      payload: 'item x',
    );

    // Handle the incoming message when the app is in the foreground.
    log("onMessage: $message");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the message when the app is in the background and opened from the notification.
    log("onMessageOpenedApp: $message");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the message when the app is terminated, but opened from the notification.
  log("onBackgroundMessage: $message");
}
