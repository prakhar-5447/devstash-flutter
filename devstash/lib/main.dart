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
  late dynamic data;
  final SignupRequest userData = SignupRequest('', '', 'pratham-0094', '',
      'sahupratham022003@gmail.com', '9981028157', 'hello everyone');

  @override
  void initState() {
    super.initState();
    // _getData();
  }

  void _getData() async {
    data = (await UserServices().updateProfile(userData));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          log(data.toString());
        }));
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
          ),
          routes: {
            // '/': (context) => const WelcomeScreen(title: "hello"),
            // '/': (context) => const ProjectDetailScreen(),
            // '/': (context) => const Project(),
            // '/': (context) => const Saved(),
            // '/': (context) => MyHomePage(title: "hello"),
            '/': (context) => WelcomeScreen(title: "welcome"),
            '/calendar': (context) => CalendarScreen(context),
            // '/': (context) => const ProfileScreen(),
          }),
    );
  }
}
