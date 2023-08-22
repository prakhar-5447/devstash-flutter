import 'dart:developer';

import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/ProfileScreen.dart';
import 'package:devstash/screens/project.dart';
import 'package:devstash/services/userServices.dart';
import 'package:devstash/widgets/AppDrawer.dart';
import 'package:devstash/widgets/WeekdayTaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}) {
    init();
  }

  late UserState user = UserState("", "", "", "", "", "");
  late final token;

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    if (token != null) {
      dynamic res = await UserServices().getUser(token);
      if (res["success"]) {
        user = res['data'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }

    return Scaffold(
        drawer: AppDrawer(
          currentIndex: 0,
        ),
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            user?.name ?? '',
                            style: const TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            user.username,
                            style: const TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Color.fromARGB(255, 165, 165, 165),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset(
                      'assets/profile.jpg',
                      width: 35.0,
                      height: 35.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,\n${user?.name}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(17, 35, 17, 38),
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.939, -0.91),
                          end: Alignment(0.954, 1),
                          colors: <Color>[Color(0xff758bfd), Color(0xcc758bfd)],
                          stops: <double>[0, 1],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color.fromARGB(255, 255, 255, 255),
                            spreadRadius: -10.0,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Project()),
                          )
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 55, 4),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '12',
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 35,
                                      fontWeight: FontWeight.w500,
                                      height: 1.115,
                                      color: Color(0xfff1f2f6),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    'assets/arrow.svg',
                                    height: 15.0,
                                    width: 30.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 122,
                              ),
                              child: const Text(
                                'PROJECTS COMPLETED',
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  height: 1.115,
                                  color: Color(0xfff1f2f6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: WeekdayTaskScreen(),
            ),
          ]),
        ));
  }
}
