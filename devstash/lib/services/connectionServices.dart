import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/connectionRequest.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class ConnectionServices {
  dynamic connection(String token, ConnectionRequest connect) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.connectionEndpoint);
      var headers = {
        'Authorization': token,
      };

      var response = await http.put(url,
          headers: headers, body: jsonEncode(connect.toJson()));
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getFollowing(String id) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.followingEndpoint + id);

      var response = await http.get(url);
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getFollower(String id) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.followerEndpoint + id);

      var response = await http.get(url);
      return dataFromJson(response.body);
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
    List<String> users = userFromJson(json);
    return {"success": success, "msg": msg, "data": users};
  }

  return {"success": success, "msg": msg, "data": {}};
}

List<String> userFromJson(String json) {
  final connect = jsonDecode(json)['data'];

  List<String> users = List<String>.from(connect);

  return users;
}
