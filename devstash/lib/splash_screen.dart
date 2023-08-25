import 'dart:developer';

import 'package:devstash/binding_screens.dart';
import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/screens/home/home_screen.dart';
import 'package:devstash/screens/auth/welcome_screen.dart';
import 'package:devstash/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String token;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  void loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';

    Future.delayed(const Duration(seconds: 2), () async {
      if (token.isEmpty) {
        Get.off(() => WelcomeScreen());
      } else {
        try {
          dynamic res = await UserServices().getUser(token);
          if (res["success"]) {
            UserState userData = res["data"];
            Get.find<UserController>().user = userData;
            Get.off(() => BindingScreen());
          } else {
            Get.off(() => WelcomeScreen());
          }
        } catch (error) {
          log(error.toString());
          Get.off(() => WelcomeScreen());
        }
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
