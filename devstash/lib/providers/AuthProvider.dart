import 'package:devstash/models/response/user_state.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  UserState? _user;

  String? get token => _token;
  UserState? get user => _user;

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  void setUser(UserState? user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
