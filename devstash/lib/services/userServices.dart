import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/userResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class UserServices {
  Future<UserResponse?> getUser(String? authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUserEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        UserResponse user = userFromJson(response.body);
        return user;
      }
    } catch (e) {
      log(e.toString());
    }
  }

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
}

UserResponse userFromJson(String json) {
  final userData = jsonDecode(json);

  String id = userData['ID'];
  String name = userData['Name'];
  String avatar = "";
  String username = userData['Username'];
  String password = userData['Password'];
  String email = userData['Email'];
  String phone = "";
  String description = userData['Description'];

  UserResponse user = UserResponse(
    id,
    name,
    avatar,
    username,
    password,
    email,
    phone,
    description,
  );

  return user;
}
