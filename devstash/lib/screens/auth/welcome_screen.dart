import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devstash/screens/auth/login_modal.dart';
import 'package:devstash/screens/auth/signup_modal.dart';

class WelcomeScreen extends StatelessWidget {
  final ModalController _controller = Get.put(ModalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Image.asset(
              'assets/welcome.png',
              width: 250,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 50, right: 0, bottom: 80),
              child: Column(
                children: [
                  const Text(
                    "Welcome to DevStash- Your Ultimate Developer's Companion!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Unleash the power of creativity and innovation with our cutting-edge platform designed to fuel your coding journey. Whether you're a seasoned developer or just starting out",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onLongPress: () {
                _showModal();
              },
              onPressed: () {
                _showModal();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Let's Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  void _showModal() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(50, 50),
            topRight: Radius.elliptical(50, 50),
          ),
          color: Color.fromARGB(255, 241, 242, 246),
        ),
        child: Obx(() {
          return _controller.showLoginModal.value
              ? LoginModal()
              : SignupModal();
        }),
      ),
    );
  }
}

class ModalController extends GetxController {
  var showLoginModal = false.obs;

  void changeForm(bool value) {
    showLoginModal.value = value;
  }
}
