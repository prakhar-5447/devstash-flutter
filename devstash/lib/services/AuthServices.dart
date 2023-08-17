import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/signinRequest.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/LoginResponse.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class AuthServices {
  dynamic signupUser(SignupRequest signupData) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.signupEndpoint);
      var response =
          await http.post(url, body: jsonEncode(signupData.toJson()));
      return dataFromJson(response.body);
    } catch (error) {
      log('Error during signin: $error');
      throw Exception('An error occurred during signin');
    }
  }

  dynamic signinUser(SigninRequest loginData) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.signinEndpoint);
      var response = await http.post(url, body: jsonEncode(loginData.toJson()));
      return dataFromJson(response.body);
    } catch (error) {
      log('Error during login: $error');
      throw Exception('An error occurred during login');
    }
  }
}

dynamic dataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    String token = authData['token'];
    UserResponse userId = userFromJson(json);
    LoginResponse user = LoginResponse(token, userId);
    return {"success": success, "msg": msg, "data": user};
  }

<<<<<<< HEAD
  String token = authData['token'];
  UserState userId = userFromJson(json);

  LoginResponse user = LoginResponse(token, userId);
  return user;
=======
  return {"success": success, "msg": msg, "data": {}};
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
}

UserState userFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['user'];

  String id = json['ID'];
  String name = json['Name'];
  String avatar = json['Avatar'];
  String username = json['Username'];
  String email = json['Email'];
  String description = json['Description'];

<<<<<<< HEAD
  UserState user = UserState(
      id, name, avatar, username, email, description);
=======
  UserResponse user =
      UserResponse(id, name, avatar, username, password, email, description);
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
  return user;
}
