import 'dart:convert';
import 'dart:developer';

import 'package:devstash/constants.dart';
import 'package:devstash/models/request/socialsRequest.dart';
import 'package:devstash/models/response/socialsResponse.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;

class SocialServices {
  dynamic getSocials(String authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.socialsEndpoint);
      var headers = {'Authorization': authToken};

      var response = await http.get(url, headers: headers);
      return dataFromJson(response.body);
    } catch (error) {
      log('Error during fetching: $error');
      throw Exception('An error occurred during fetching');
    }
  }

  dynamic updateSocials(String? authToken, SocialsRequest socials) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.socialsEndpoint);
      var headers = {'Authorization': authToken ?? " "};

      var response = await http.put(url,
          headers: headers, body: jsonEncode(socials.toJson()));
      return Helper().responseFromJson(response.body);
    } catch (error) {
      log('Error during fetching: $error');
      throw Exception('An error occurred during fetching');
    }
  }
}

dynamic dataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    SocialsResponse social = socialFromJson(json);
    return {"success": success, "msg": msg, "data": social};
  }

  return {"success": success, "msg": msg, "data": {}};
}

SocialsResponse socialFromJson(String json) {
  final data = jsonDecode(json)['data'];

  String userId = data['UserId'];
  String twitter = data['Twitter'];
  String github = data['Github'];
  String linkedin = data['Linkedin'];
  String instagram = data['Instagram'];
  String other = data['Other'];

  SocialsResponse socials =
      SocialsResponse(userId, twitter, github, linkedin, instagram, other);
  return socials;
}
