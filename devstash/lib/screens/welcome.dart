import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.title});
  final String title;
  static String routeName = '/';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

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
                  // showModalBottomSheet<void>(
                  //   isScrollControlled: true,
                  //   context: context,
                  //   backgroundColor: Colors.transparent,
                  //   builder: (BuildContext context) {
                  //     return Container(
                  //       height: 650,
                  //       decoration: const BoxDecoration(
                  //           borderRadius: BorderRadius.only(
                  //               topLeft: Radius.elliptical(50, 50),
                  //               topRight: Radius.elliptical(50, 50)),
                  //           color: Color.fromARGB(232, 239, 235, 235)),
                  //       child: Column(children: [
                  //         const Expanded(
                  //             flex: 1,
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 Text(
                  //                   "Create New account",
                  //                   style: TextStyle(
                  //                       color: Color.fromARGB(255, 0, 0, 0),
                  //                       fontFamily: 'Comfortaa',
                  //                       fontWeight: FontWeight.w400,
                  //                       fontSize: 25),
                  //                 ),
                  //               ],
                  //             )),
                  //         Expanded(
                  //           flex: 7,
                  //           child: Container(
                  //             decoration: const BoxDecoration(
                  //                 color: Color.fromARGB(255, 255, 255, 255),
                  //                 borderRadius: BorderRadius.only(
                  //                     topLeft: Radius.elliptical(50, 50),
                  //                     topRight: Radius.elliptical(50, 50))),
                  //             child: Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   vertical: 10, horizontal: 40),
                  //               child: Column(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                   Column(
                  //                     children: [
                  //                       Padding(
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 50),
                  //                         child: Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             Container(
                  //                               width: 45,
                  //                               height: 45,
                  //                               padding:
                  //                                   const EdgeInsets.all(10),
                  //                               decoration: BoxDecoration(
                  //                                 border: Border.all(
                  //                                     color: Colors.black),
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(30),
                  //                                 color: Colors.white,
                  //                               ),
                  //                               child: Image.asset(
                  //                                 'assets/google.png',
                  //                                 fit: BoxFit.contain,
                  //                               ),
                  //                             ),
                  //                             Container(
                  //                               width: 45,
                  //                               height: 45,
                  //                               padding:
                  //                                   const EdgeInsets.all(10),
                  //                               decoration: BoxDecoration(
                  //                                 border: Border.all(
                  //                                     color: Colors.black),
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(30),
                  //                                 color: Colors.white,
                  //                               ),
                  //                               child: Image.asset(
                  //                                 'assets/github.png',
                  //                                 fit: BoxFit.contain,
                  //                               ),
                  //                             ),
                  //                             Container(
                  //                               width: 45,
                  //                               height: 45,
                  //                               padding:
                  //                                   const EdgeInsets.all(10),
                  //                               decoration: BoxDecoration(
                  //                                 border: Border.all(
                  //                                     color: Colors.black),
                  //                                 borderRadius:
                  //                                     BorderRadius.circular(30),
                  //                                 color: Colors.white,
                  //                               ),
                  //                               child: Image.asset(
                  //                                 'assets/linkedin.png',
                  //                                 fit: BoxFit.contain,
                  //                               ),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       const Padding(
                  //                           padding: EdgeInsets.only(top: 15),
                  //                           child: Row(children: [
                  //                             Expanded(
                  //                                 child: Divider(
                  //                               color: Color.fromARGB(
                  //                                   197, 144, 144, 144),
                  //                               height: 25,
                  //                               thickness: 2,
                  //                               indent: 5,
                  //                               endIndent: 5,
                  //                             )),
                  //                             Padding(
                  //                               padding: EdgeInsets.symmetric(
                  //                                   horizontal: 10),
                  //                               child: Text("or",
                  //                                   style: TextStyle(
                  //                                       color: Color.fromARGB(
                  //                                           197, 144, 144, 144),
                  //                                       fontFamily: 'Comfortaa',
                  //                                       fontWeight:
                  //                                           FontWeight.w400,
                  //                                       fontSize: 20)),
                  //                             ),
                  //                             Expanded(
                  //                                 child: Divider(
                  //                               color: Color.fromARGB(
                  //                                   197, 144, 144, 144),
                  //                               height: 25,
                  //                               thickness: 2,
                  //                               indent: 5,
                  //                               endIndent: 5,
                  //                             )),
                  //                           ])),
                  //                     ],
                  //                   ),
                  //                   const Column(children: [
                  //                     Padding(
                  //                       padding:
                  //                           EdgeInsets.symmetric(vertical: 10),
                  //                       child: TextField(
                  //                         decoration: InputDecoration(
                  //                           border: OutlineInputBorder(),
                  //                           labelText: 'Name',
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                         padding: EdgeInsets.symmetric(
                  //                             vertical: 10),
                  //                         child: TextField(
                  //                           decoration: InputDecoration(
                  //                             border: OutlineInputBorder(),
                  //                             labelText: 'Email',
                  //                           ),
                  //                         )),
                  //                     Padding(
                  //                         padding: EdgeInsets.symmetric(
                  //                             vertical: 10),
                  //                         child: TextField(
                  //                           decoration: InputDecoration(
                  //                             border: OutlineInputBorder(),
                  //                             // hintText: 'Enter Password',
                  //                             labelText: 'Password',
                  //                           ),
                  //                         )),
                  //                     Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                       children: [
                  //                         Text("Medium",
                  //                             style: TextStyle(
                  //                                 color: Color.fromARGB(
                  //                                     255, 231, 34, 34),
                  //                                 fontFamily: 'Comfortaa',
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontSize: 16)),
                  //                         Row(
                  //                           children: [],
                  //                         )
                  //                       ],
                  //                     )
                  //                   ]),
                  //                   Column(children: [
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsets.only(bottom: 15),
                  //                       child: ElevatedButton(
                  //                           style: const ButtonStyle(
                  //                               backgroundColor:
                  //                                   MaterialStatePropertyAll<
                  //                                           Color>(
                  //                                       Color.fromARGB(255, 33,
                  //                                           149, 221))),
                  //                           onPressed: () =>
                  //                               Navigator.pop(context),
                  //                           child: const Padding(
                  //                               padding: EdgeInsets.only(
                  //                                   left: 50,
                  //                                   top: 12,
                  //                                   right: 50,
                  //                                   bottom: 12),
                  //                               child: Text(
                  //                                 "REGISTER",
                  //                                 style: TextStyle(
                  //                                     color: Color.fromARGB(
                  //                                         221, 221, 215, 215),
                  //                                     fontFamily: 'Comfortaa',
                  //                                     fontWeight:
                  //                                         FontWeight.w400,
                  //                                     fontSize: 22),
                  //                               ))),
                  //                     ),
                  //                     const Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         Text(
                  //                           "Already have an account?",
                  //                           style: TextStyle(
                  //                               color: Color.fromARGB(
                  //                                   197, 144, 144, 144),
                  //                               fontFamily: 'Comfortaa',
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 18),
                  //                         ),
                  //                         SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                         Text(
                  //                           "Login here",
                  //                           style: TextStyle(
                  //                               color: Color.fromARGB(
                  //                                   255, 24, 178, 250),
                  //                               fontFamily: 'Comfortaa',
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 18),
                  //                         ),
                  //                       ],
                  //                     )
                  //                   ]),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       ]),
                  //     );
                  //   },
                  // );
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        height: 650,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(50, 50),
                                topRight: Radius.elliptical(50, 50)),
                            color: Color.fromARGB(232, 239, 235, 235)),
                        child: Column(children: [
                          const Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Login to your account",
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
                                      topLeft: Radius.elliptical(50, 50),
                                      topRight: Radius.elliptical(50, 50))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 45,
                                                height: 45,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white,
                                                ),
                                                child: Image.asset(
                                                  'assets/google.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Container(
                                                width: 45,
                                                height: 45,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white,
                                                ),
                                                child: Image.asset(
                                                  'assets/github.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Container(
                                                width: 45,
                                                height: 45,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.white,
                                                ),
                                                child: Image.asset(
                                                  'assets/linkedin.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 15),
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text("or",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            197, 144, 144, 144),
                                                        fontFamily: 'Comfortaa',
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
                                    Column(
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Email',
                                              ),
                                            )),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                // hintText: 'Enter Password',
                                                labelText: 'Password',
                                              ),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scaleX: 0.7,
                                                  scaleY: 0.6,
                                                  child: Switch(
                                                    onChanged: toggleSwitch,
                                                    value: isSwitched,
                                                    activeColor: Colors.blue,
                                                    activeTrackColor:
                                                        const Color.fromARGB(
                                                            255, 174, 183, 254),
                                                    inactiveThumbColor:
                                                        Colors.blue,
                                                    inactiveTrackColor:
                                                        const Color.fromARGB(
                                                            239, 242, 236, 236),
                                                  ),
                                                ),
                                                const Text("Remember me",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            235, 189, 183, 183),
                                                        fontFamily: 'Comfortaa',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                            const Text("Forget password?",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 24, 178, 250),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<
                                                            Color>(
                                                        Color.fromARGB(255, 33,
                                                            149, 221))),
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
                                                      color: Color.fromARGB(
                                                          221, 221, 215, 215),
                                                      fontFamily: 'Comfortaa',
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
                                            "Don't have an account?",
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
                                            "Register here",
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
                      );
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
