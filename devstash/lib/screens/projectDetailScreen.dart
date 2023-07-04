import 'dart:ui';
import 'package:devstash/models/Collaborator.dart';
import 'package:devstash/models/Hashtag.dart';
import 'package:devstash/models/TechStack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TechStack> tech = [
      TechStack("assets/google.png", "google"),
      TechStack("assets/linkedin.png", "linkedin"),
      TechStack("assets/github.png", "github"),
    ];
    final List<Collaborator> collab = [
      Collaborator("assets/google.png", "PRAKHAR SAHU"),
      Collaborator("assets/linkedin.png", "PRATHAM SAHU"),
      Collaborator("assets/github.png", "SUYASH SAHU"),
    ];
    final List<Hashtag> hash = [
      Hashtag("web"),
      Hashtag("frontend"),
      Hashtag("backend"),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(57, 174, 183, 254),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 380,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50)),
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.dstATop),
                              image: const AssetImage("assets/todo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 4,
                              sigmaY: 4,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 40, bottom: 20),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Image.asset(
                                        'assets/todo.png',
                                        height: 200,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Juicy-N-Yummy",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 75, 73, 70),
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20)),
                                  Text("Medium",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 165, 165, 165),
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                ],
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 117, 140, 253)))),
                                      backgroundColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Color.fromARGB(
                                                  255, 117, 140, 253))),
                                  onPressed: () => {},
                                  child: const Text(
                                    "view code",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 234, 228, 228),
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.justify,
                            text: const TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "Juicy-N-Yummy is an platform for restaurant aggregator and food delivery. It provides information, menus and user-reviews of restaurants as well as food delivery options from partner restaurants in select cities.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus."),
                              ],
                              style: TextStyle(
                                  height: 1.3,
                                  color: Color.fromARGB(255, 165, 165, 165),
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: SvgPicture.asset(
                                        "assets/tech-stack.svg",
                                        height: 30,
                                      ),
                                    ),
                                    const Text("TECH STACK",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 165, 165, 165),
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: tech.map((item) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30),
                                                child: Container(
                                                  width: 45,
                                                  height: 45,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.white,
                                                  ),
                                                  child: Image.asset(
                                                    item.icon,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Text("COLLABORATORS",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 165, 165, 165),
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: collab.map((item) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              241,
                                                              242,
                                                              246)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          item.avatar,
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: Text(item.name,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          39,
                                                                          24,
                                                                          126),
                                                                  fontFamily:
                                                                      'Comfortaa',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: hash.map((item) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: Color.fromARGB(
                                                    255, 39, 24, 126)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              child: Text(item.hashtag,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 241, 242, 246),
                                                      fontFamily: 'Comfortaa',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12)),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    )),
                              )),
                        ],
                      )),
                ),
              )
            ],
          ),
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
                backgroundColor: const Color.fromARGB(255, 174, 183, 254),
                onPressed: () {},
                elevation: 0,
                child: const Icon(
                  Icons.star_rounded,
                  color: Color.fromARGB(255, 254, 237, 89),
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
