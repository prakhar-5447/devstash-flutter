import 'package:get/get.dart';
import 'package:devstash/models/response/user_state.dart';

class UserController extends GetxController {
  final RxString _token = ''.obs;
  final Rx<UserState?> _user = Rx<UserState?>(null);

  String? get token => _token.value;
  set token(String? value) => _token.value = value ?? '';

  UserState? get user => _user.value;
  set user(UserState? value) => _user.value = value;

  void logout() {
    token = '';
    user = null;
  }
}
