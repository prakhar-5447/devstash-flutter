import 'package:devstash/models/response/userResponse.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  UserResponse? _user;

  String? get token => _token;
  UserResponse? get user => _user;

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  void setUser(UserResponse? user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
