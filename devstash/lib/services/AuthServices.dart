import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/loginRequest.dart';
import 'package:devstash/models/response/LoginResponse.dart';
import 'package:devstash/models/response/userResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class AuthServices {
  Future<LoginResponse?> loginUser(LoginRequest loginData) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);
      var response = await http.post(url, body: jsonEncode(loginData.toJson()));

      if (response.statusCode == 200) {
        return dataFromJson(response.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      log('Error during login: $error');
      throw Exception('An error occurred during login');
    }
  }
}

LoginResponse dataFromJson(String json) {
  final authData = jsonDecode(json);

  String token = authData['token'];
  UserResponse userId = userFromJson(json);

  LoginResponse user = LoginResponse(token, userId);
  return user;
}

UserResponse userFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['user'];

  String id = json['ID'];
  String name = json['Name'];
  String avatar = "";
  String username = json['Username'];
  String password = json['Password'];
  String email = json['Email'];
  String phone = "";
  String description = json['Description'];

  UserResponse user = UserResponse(
      id, name, avatar, username, password, email, phone, description);
  return user;
}
