import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/educationRequest.dart';
import 'package:devstash/models/response/education.dart';
import 'package:http/http.dart' as http;

class EducationServices {
  Future<dynamic> updateEducation(
      EducationRequest education, String? authToken) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.educationEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(education.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> create(EducationRequest education, String? authToken) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.educationEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.post(url,
          headers: headers, body: jsonEncode(education.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<EducationResponse>?> getEducation(String? authToken) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.educationEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return educationFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> deleteEducation(String? authToken, String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.educationEndpoint + '/' + id);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.delete(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return "deleted";
      }
    } catch (e) {
      log(e.toString());
    }
  }

  List<EducationResponse> educationFromJson(String jsonData) {
    final json = jsonDecode(jsonData);

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
}
