import 'package:devstash/controllers/auth_controller.dart';
import 'package:devstash/screens/auth/login_modal.dart';
import 'package:devstash/screens/auth/signup_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final ModalController _controller = Get.put(ModalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: Image.asset(
              'assets/auth_screen.png',
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Obx(() {
                  return _controller.showLoginModal.value
                      ? LoginModalContent()
                      : SignupModalContent();
                }),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Color.fromARGB(197, 144, 144, 144),
                      height: 25,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(
                          color: Color.fromARGB(197, 144, 144, 144),
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(197, 144, 144, 144),
                        height: 25,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/linkedin.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SafeArea(
              bottom: true,
              child: Obx(
                () {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _controller.showLoginModal.value
                              ? "Don't have an account?"
                              : "Already have an account?",
                          style: const TextStyle(
                            color: Color.fromARGB(197, 144, 144, 144),
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.find<ModalController>()
                                .changeForm(!_controller.showLoginModal.value);
                          },
                          child: Text(
                            _controller.showLoginModal.value
                                ? "Create new"
                                : "Register here",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 24, 178, 250),
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
