import 'package:get/get.dart';

class PasswordController extends GetxController {
  final RxDouble passwordStrength = 0.0.obs;

  void updatePasswordStrength(String password) {
    double strength = password.length / 10;
    passwordStrength.value = strength;
  }
}
