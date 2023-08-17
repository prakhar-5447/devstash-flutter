import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class UserServices {
<<<<<<< HEAD
  Future<UserState?> getUser(String? authToken) async {
=======
  dynamic getUser(String authToken) async {
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUserEndpoint);
      var headers = {
        'Authorization': authToken,
      };
      var response = await http.get(url, headers: headers);
<<<<<<< HEAD
      if (response.statusCode == 200) {
        UserState user = userFromJson(response.body);
        return user;
      }
=======
      return dataFromJson(response.body);
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
    } catch (e) {
      log(e.toString());
    }
  }

<<<<<<< HEAD
  Future<dynamic> updateProfile(
      UserProfile userDetails, String? authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.profileEndpoint);
      var headers = {
        'Authorization':
            'v2.local.ow0toI21W9vnZhZXdJ--WdoKiSUmDzjXnqEkv9WMWK67BGZPSgv_pM2EXQSs8YNPygVjVP3wwCjMKSUbmEfUths-HLa7HDR5DocCVnFmHhMk6PhKUvwH4JTjjOSbkIzpqXGghJUdb95xbCfa2RKcWXIVO1Wj9cZzE9qk5GamAqupwXcIrTBLQKyf_TNhkxm2Z0TSzx-9yehFw71jKo6VzOnIYCJOkkAwg42OZzSoM80-q3xxblfQm8Y8QBVJXSOtRgpt8V4xLPAWUkrs-Z4Hp6xkwD5aWaS7uy80VfmrnsGoyfnDvOG1WngC2LTFYKrc.bnVsbA',
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(userDetails.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserState?> getUserById(String id) async {
=======
  dynamic getUserById(String id) async {
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getUserByIdEndpoint + id);
      var response = await http.get(url);
<<<<<<< HEAD
      if (response.statusCode == 200) {
        UserState user = userFromJson(response.body);
        return user;
      }
=======
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic updateProfile(UserProfile userDetails, String authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.profileEndpoint);
      var headers = {'Authorization': authToken};
      var response = await http.put(url,
          headers: headers, body: jsonEncode(userDetails.toJson()));
      return jsonDecode(response.body);
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
    } catch (e) {
      log(e.toString());
    }
  }
}

<<<<<<< HEAD
UserState userFromJson(String json) {
  final userData = jsonDecode(json);

  String id = userData['ID'];
  String name = userData['Name'];
  String avatar = userData['Avatar'];
  String username = userData['Username'];
  String email = userData['Email'];
  String description = userData['Description'];

  UserState user = UserState(
    id,
    name,
    avatar,
    username,
    email,
    description,
  );
=======
dynamic dataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    UserResponse user = userFromJson(json);
    return {"success": success, "msg": msg, "data": user};
  }

  return {"success": success, "msg": msg, "data": {}};
}

UserResponse userFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['user'];
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c

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
