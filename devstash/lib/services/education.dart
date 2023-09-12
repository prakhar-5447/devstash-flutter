import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/educationRequest.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;

class EducationServices {
  dynamic updateEducation(
      EducationRequest education, String token) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.educationEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(education.toJson()));
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic create(EducationRequest education, String token) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.educationEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.post(url,
          headers: headers, body: jsonEncode(education.toJson()));
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getEducation(String token) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.educationEndpoint);
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

  dynamic deleteEducation(String token, String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.educationEndpoint + '/' + id);
      var headers = {
        'Authorization': token,
      };
      var response = await http.delete(
        url,
        headers: headers,
      );
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
    List<EducationResponse> education = educationFromJson(json);
    return {"success": success, "msg": msg, "data": education};
  }

  return {"success": success, "msg": msg, "data": {}};
}

List<EducationResponse> educationFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['data'];

  List<EducationResponse> eduList = [];
  for (var i in json) {
    String level = i['Level'];
    String id = i['ID'];
    String userid = i['UserId'];
    String schoolName = i['SchoolName'];
    String subject = i['Subject'];
    String fromYear = i['FromYear'];
    String toYear = i['ToYear'];
    eduList.add(EducationResponse(
        id: id,
        userid: userid,
        educationLevel: level,
        subject: subject,
        fromYear: fromYear,
        toYear: toYear,
        collegeorSchoolName: schoolName));
  }

  return eduList;
}
