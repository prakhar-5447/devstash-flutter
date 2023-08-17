import 'package:get/get.dart';

class ModalController extends GetxController {
  var showLoginModal = false.obs;

  void changeForm(bool value) {
    showLoginModal.value = value;
  }
}
