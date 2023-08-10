import 'package:devstash/models/response/user_state.dart';

class LoginResponse {
  String _token;
  UserState _user;

  LoginResponse(this._token, this._user);

  String get token => _token;
  set token(String value) => _token = value;

  UserState get user => _user;
  set user(UserState value) => _user = value;

  @override
  String toString() {
    return 'LoginResponse{user: $_user, token: $_token}';
  }
}
