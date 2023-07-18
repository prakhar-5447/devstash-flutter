import 'dart:developer';

import 'package:devstash/widgets/LoginModal.dart';
import 'package:devstash/widgets/PasswordStrengthBar.dart';
import 'package:devstash/widgets/SignupModal.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.title});
  final String title;
  static String routeName = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showLoginModal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 117, 140, 253),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Image.asset(
                'assets/welcome.png',
                width: 300,
                fit: BoxFit.contain,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 0, top: 50, right: 0, bottom: 80),
                child: Column(
                  children: [
                    Text(
                      "Welcome to DevStash\n- Your Ultimate Developer's Companion!",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w700,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Unleash the power of creativity and innovation with our cutting-edge platform designed to fuel your coding journey. Whether you're a seasoned developer or just starting out",
                      style: TextStyle(
                          color: Color.fromARGB(255, 174, 183, 254),
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showLoginModal = false;
                  });
                  _showModal();
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 39, 24, 126))),
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 15, right: 50, bottom: 15),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      "Let's Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 24,
                      color: Colors.white,
                    ),
                  ]),
                ),
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ));
  }

  void _showModal() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(50, 50),
                topRight: Radius.elliptical(50, 50)),
            color: Color.fromARGB(255, 241, 242, 246),
          ),
          child: _showLoginModal
              ? LoginModal(
                  changeForm: (value) {
                    setState(
                      () {
                        _showLoginModal = value;
                      },
                    );
                  },
                )
              : SignupModal(
                  changeForm: (value) {
                    setState(
                      () {
                        _showLoginModal = value;
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
