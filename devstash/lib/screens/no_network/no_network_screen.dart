import 'package:devstash/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 98, right: 58),
                child: Image(image: AssetImage('assets/splash.png')),
              )),
              const SizedBox(
                height: 20,
              ),
              const Text('No Network ! ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 117, 117, 117))),
              TextButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomeScreen())));
                  },
                  child: const Text('Retry ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 145, 145, 145)))),
            ]),
      ),
    ));
  }
}
