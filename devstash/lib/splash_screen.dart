import 'package:devstash/screens/HomeScreen.dart';
import 'package:devstash/screens/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = '';

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';

    Future.delayed(const Duration(seconds: 2), () {
      if (token.isEmpty) {
        Get.off(WelcomeScreen());
      } else {
        Get.off(HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/splash.png',
          ),
        ),
      ),
    );
  }
}
