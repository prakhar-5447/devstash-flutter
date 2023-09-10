import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/educationRequest.dart';
import 'package:devstash/models/request/skillRequest.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/models/response/skillResponse.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;

class SkillServices {
  dynamic updateskill(SkillRequest skill, String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.skillsEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(skill.toJson()));
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getskill(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.skillsEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic deleteskill(String token, SkillRequest skill) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.skillsEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.delete(url,
          headers: headers, body: jsonEncode(skill.toJson()));
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
    SkillResponse skill = skillFromJson(json);
    return {"success": success, "msg": msg, "data": skill};
  }

  return {"success": success, "msg": msg, "data": {}};
}

SkillResponse skillFromJson(String jsonData) {
  final json = jsonDecode(jsonData)["data"];

  List<String> skills = [];
  String id = json['ID'];
  String userid = json['UserID'];
  for (var i in json["Skills"]) {
    skills.add(i);
  }
  SkillResponse res = SkillResponse(id: id, userid: userid, skills: skills);
  return res;
}
