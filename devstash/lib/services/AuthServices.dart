import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/signinRequest.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/LoginResponse.dart';
import 'package:devstash/models/response/userResponse.dart';
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

  return {"success": success, "msg": msg, "data": {}};
}

UserResponse userFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['user'];

  String id = json['ID'];
  String name = json['Name'];
  String avatar = json['Avatar'];
  String username = json['Username'];
  String password = json['Password'];
  String email = json['Email'];
  String description = json['Description'];

  UserResponse user =
      UserResponse(id, name, avatar, username, password, email, description);
  return user;
}
