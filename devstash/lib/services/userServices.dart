import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class UserServices {
  dynamic getUser(String authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUserEndpoint);
      var headers = {
        'Authorization': authToken,
      };
      var response = await http.get(url, headers: headers);
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getUserById(String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getUserByIdEndpoint + id);
      var response = await http.get(url);
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
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}

dynamic dataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    UserState user = userFromJson(json);
    return {"success": success, "msg": msg, "data": user};
  }

  return {"success": success, "msg": msg, "data": {}};
}

UserState userFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['data'];

  String id = json['ID'];
  String name = json['Name'];
  String avatar = json['Avatar'];
  String username = json['Username'];
  String email = json['Email'];
  String description = json['Description'];

  UserState user = UserState(id, name, avatar, username, email, description);
  return user;
}
