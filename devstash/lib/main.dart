import 'package:devstash/controllers/tabs_controller.dart';
import 'package:devstash/controllers/user_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:devstash/connectivity_handler.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      initialBinding: InitialBindings(),
      title: 'Devstash',
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        primaryColor: const Color.fromARGB(255, 117, 140, 253),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 174, 183, 254),
          secondary: Color.fromARGB(255, 39, 24, 126),
          tertiary: Color.fromARGB(255, 254, 237, 89),
          background: Color.fromARGB(255, 117, 140, 253),
          error: Color.fromARGB(255, 255, 95, 95),
        ),
      ),
      home: const ConnectivityHandler(),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(BottomTabController());
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  showDialog(
    context: navigatorKey.currentContext!, // Access the context here
    builder: (BuildContext context) => AlertDialog(
      title: Text(title ?? ''),
      content: Text(body ?? ''),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () async {},
          child: Text('Go to Second Screen'),
        ),
      ],
    ),
  );
}
