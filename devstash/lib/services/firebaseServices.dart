import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class FirebaseServices {
  Future<String?> getFCMToken() async {
    String? token;

    try {
      await _firebaseMessaging.requestPermission();

      token = await _firebaseMessaging.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
    }

    return token;
  }
}
