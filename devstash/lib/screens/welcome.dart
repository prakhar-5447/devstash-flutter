import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.title});
  final String title;
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 117, 140, 253),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Image.asset(
                'assets/images.jpeg',
                width: 600,
                fit: BoxFit.fill,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 0, top: 100, right: 0, bottom: 100),
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
                onPressed: () {},
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
}
