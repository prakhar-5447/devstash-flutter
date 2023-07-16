import 'package:devstash/models/response/userResponse.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

// screens
import 'package:devstash/models/response/projectResponse.dart';
import 'package:devstash/screens/saved.dart';
import 'package:devstash/screens/project.dart';
import 'package:devstash/screens/projectDetailScreen.dart';
import 'package:devstash/screens/welcome.dart';
import 'package:devstash/screens/HomeScreen.dart';
import 'package:devstash/screens/ProfileScreen.dart';

// services
import 'package:devstash/services/projectServices.dart';
import 'package:devstash/services/userServices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserResponse? _user;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user = (await UserServices().getUser());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          log(_user.toString());
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          '/': (context) => const HomeScreen(),
          // '/': (context) => const ProfileScreen(),
        });
  }
}
