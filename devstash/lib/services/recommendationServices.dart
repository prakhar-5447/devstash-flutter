import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/response/user_recommended.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class RecomendationServices {
  dynamic getUserRecommendation(String authToken, String num) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getRecommendedUserEndpoint + num);
      var headers = {
        'Authorization': authToken,
      };
      var response = await http.get(url, headers: headers);
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
    List<RecommendedUser> user = userFromJson(json);
    return {"success": success, "msg": msg, "data": user};
  }

  return {"success": success, "msg": msg, "data": {}};
}

List<RecommendedUser> userFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['data'];
  List<RecommendedUser> recommendedUsers = [];

  for (var user in json) {
    String id = user['id'];
    String name = user['name'];
    String avatar = user['avatar'];
    RecommendedUser recommendedUser = RecommendedUser(id, name, avatar);
    recommendedUsers.add(recommendedUser);
  }

  return recommendedUsers;
}
