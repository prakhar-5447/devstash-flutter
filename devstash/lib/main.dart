import 'package:devstash/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:devstash/connectivity_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
  }
}
