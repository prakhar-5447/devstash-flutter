import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Project extends StatelessWidget {
  const Project({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                Text("PROJECTS",
                    style: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    left: BorderSide(
                      color: Color.fromARGB(255, 174, 183, 254),
                      width: 5.0,
                    ),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/todo.png",
                              height: 100,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/tech-stack.svg",
                                height: 25,
                              ),
                              const Column(
                                children: [
                                  Text("Juicy-N-Yummy",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 75, 73, 70),
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15)),
                                  Text("Medium",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 165, 165, 165),
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews ...",
                          style: TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165),
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
