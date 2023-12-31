import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:devstash/firebase_intializer.dart';
import 'package:devstash/screens/no_network/no_network_screen.dart';
import 'package:devstash/splash_screen.dart';
import 'package:flutter/material.dart';

class ConnectivityHandler extends StatefulWidget {
  const ConnectivityHandler({super.key});

  @override
  State<ConnectivityHandler> createState() => _ConnectivityHandlerState();
}

class _ConnectivityHandlerState extends State<ConnectivityHandler> {
  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (!snapshot.hasData || snapshot.data == ConnectivityResult.none) {
          return const NoNetwork();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
