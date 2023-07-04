import 'package:flutter_svg/flutter_svg.dart';
import 'package:devstash/models/ProjectInfo.dart';
import 'package:flutter/material.dart';

class Project extends StatelessWidget {
  const Project({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProjectInfo> project = [
      ProjectInfo("Firstmy", "assets/firstmy.jpg", "27 Feb 2021", "firstmy",
          "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews ..."),
      ProjectInfo("Todo App", "assets/todo.png", "27 Feb 2021", "todo",
          "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews ..."),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
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
                padding:
                    EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 20),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                        children: project.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                            left: BorderSide(
                              color: Color.fromARGB(255, 174, 183, 254),
                              width: 5.0,
                            ),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item.image,
                                      height: 120,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/redirect.svg",
                                          height: 25,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(item.name,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 75, 73, 70),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15)),
                                            Text(item.date,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 165, 165, 165),
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    item.description,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 165, 165, 165),
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      );
                    }).toList()),
                  ),
                ),
              ),
            )
          ]),
          Positioned(
            bottom: 25,
            right: 25,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11)),
              ),
              child: FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 255, 95, 95),
                onPressed: () {},
                elevation: 0,
                child: const Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 241, 242, 246),
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
