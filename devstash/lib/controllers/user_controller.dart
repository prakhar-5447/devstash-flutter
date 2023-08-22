import 'package:get/get.dart';
import 'package:devstash/models/response/user_state.dart';

class UserController extends GetxController {
  final Rx<UserState?> _user = Rx<UserState?>(null);

  UserState? get user => _user.value;
  set user(UserState? value) {
    _user.value = value;
    update();
  }

  void logout() {
    user = null;
    update();
  }
}
