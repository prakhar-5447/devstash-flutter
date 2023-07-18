import 'package:devstash/models/response/userResponse.dart';

class LoginResponse {
  String _token;
  UserResponse _user;

  LoginResponse(this._token, this._user);

  String get token => _token;
  set token(String value) => _token = value;

  UserResponse get user => _user;
  set user(UserResponse value) => _user = value;

  @override
  String toString() {
    return 'LoginResponse{user: $_user, token: $_token}';
  }
}
