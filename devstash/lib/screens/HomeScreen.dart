import 'package:devstash/screens/WeekdayTaskScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "PRAKHAR SAHU",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "@prakhar-5447",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Color.fromARGB(255, 165, 165, 165),
                      ),
                    ),
                  ],
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Hello,\nPRAKHAR",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(17, 35, 17, 38),
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
                    blurRadius: 15,
                  ),
                ],
              ),
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
          ]),
        ),
        Container(
          child: WeekdayTaskScreen(),
        ),
      ]),
    ));
  }
}
