import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 500,
          decoration: const BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
              colorFilter: ColorFilter.linearToSrgbGamma(),
              image: AssetImage("assets/welcome.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/welcome.png',
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Juicy-N-Yummy",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 27, 26, 26),
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20)),
                          Text("Medium",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 216, 211, 211),
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18)),
                        ],
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 33, 149, 221)))),
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Color.fromARGB(255, 33, 149, 221))),
                          onPressed: () => {},
                          child: const Text(
                            "view code",
                            style: TextStyle(
                                color: Color.fromARGB(255, 234, 228, 228),
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )),
                    ],
                  )
                ]),
          ),
        ),
      ],
    ));
  }
}
