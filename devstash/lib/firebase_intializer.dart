// firebase_initializer.dart
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

void setupFirebaseMessaging() {
  _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
