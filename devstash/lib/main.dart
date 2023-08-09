import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:devstash/providers/AuthProvider.dart';

// screens
import 'package:devstash/screens/saved.dart';
import 'package:devstash/screens/project.dart';
import 'package:devstash/screens/projectDetailScreen.dart';
import 'package:devstash/screens/welcome.dart';
import 'package:devstash/screens/HomeScreen.dart';
import 'package:devstash/screens/ProfileScreen.dart';
import 'package:devstash/screens/CalendarScreen.dart';

// services
import 'package:devstash/services/bookmarkServices.dart';
import 'package:devstash/services/favoriteServices.dart';
import 'package:devstash/services/projectServices.dart';
import 'package:devstash/services/userServices.dart';

// request models
import 'package:devstash/models/request/bookmarkRequest.dart';
import 'package:devstash/models/request/favoriteRequest.dart';
import 'package:devstash/models/request/projectRequest.dart';
import 'package:devstash/models/request/signupRequest.dart';

// response models
import 'package:devstash/models/response/bookmarkResponse.dart';
import 'package:devstash/models/response/favoriteResponse.dart';
import 'package:devstash/models/response/userResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';


void main() {
  runApp(const MyApp());
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
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
          title: 'Devstash',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),        initialRoute: '/',

          routes: {
            // '/': (context) => const WelcomeScreen(title: "hello"),
            // '/': (context) => const ProjectDetailScreen(),
            // '/': (context) => const Project(),
            // '/': (context) => const Saved(),
            // '/': (context) => MyHomePage(title: "hello"),
            '/': (context) => HomeScreen(),
            '/auth': (context) => WelcomeScreen(title: "welcome"),
            '/calendar': (context) => CalendarScreen(context),
            // '/': (context) => const ProfileScreen(),
          }),
    );
  }
}
