import 'package:devstash/screens/CalendarScreen.dart';
import 'package:devstash/screens/HomeScreen.dart';
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
          '/': (context) => HomeScreen(),
          '/calendar': (context) => CalendarScreen(context),
          // '/': (context) => const ProfileScreen(),
        });
  }
}
