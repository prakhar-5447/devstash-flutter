import 'package:devstash/screens/saved.dart';
import 'package:devstash/screens/project.dart';
import 'package:devstash/screens/projectDetailScreen.dart';
import 'package:devstash/screens/welcome.dart';
import 'package:devstash/screens/HomeScreen.dart';
import 'package:devstash/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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