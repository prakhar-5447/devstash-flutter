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
                onPressed: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                          widthFactor: 1,
                          heightFactor: 0.7,
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(30, 25),
                                    topRight: Radius.elliptical(30, 25)),
                                color: Color.fromARGB(221, 221, 215, 215)),
                            child: Column(children: [
                              const Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Create New Account",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 25),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.elliptical(30, 25),
                                          topRight: Radius.elliptical(30, 25))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 50),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Column(
                                          children: [
                                            Row(),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Divider(
                                                    color: Color.fromARGB(
                                                        197, 144, 144, 144),
                                                    height: 25,
                                                    thickness: 2,
                                                    indent: 5,
                                                    endIndent: 5,
                                                  )),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Text("or",
                                                        style: TextStyle(
                                                            color: Color
                                                                .fromARGB(
                                                                    197,
                                                                    144,
                                                                    144,
                                                                    144),
                                                            fontFamily:
                                                                'Comfortaa',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20)),
                                                  ),
                                                  Expanded(
                                                      child: Divider(
                                                    color: Color.fromARGB(
                                                        197, 144, 144, 144),
                                                    height: 25,
                                                    thickness: 2,
                                                    indent: 5,
                                                    endIndent: 5,
                                                  )),
                                                ])),
                                          ],
                                        ),
                                        const Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Name',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Email',
                                                  ),
                                                )),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    // hintText: 'Enter Password',
                                                    labelText: 'Password',
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: ElevatedButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                                Color>(
                                                            Color.fromARGB(255,
                                                                33, 149, 221))),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 50,
                                                        top: 12,
                                                        right: 50,
                                                        bottom: 12),
                                                    child: Text(
                                                      "REGISTER",
                                                      style: TextStyle(
                                                          color:
                                                              Color.fromARGB(
                                                                  221,
                                                                  221,
                                                                  215,
                                                                  215),
                                                          fontFamily:
                                                              'Comfortaa',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 22),
                                                    ))),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Already have an account?",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        197, 144, 144, 144),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Login here",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 24, 178, 250),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          )
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ));
                    },
                  );
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
}
