import 'dart:convert';
import 'dart:developer';

import 'package:devstash/constants.dart';
import 'package:devstash/models/request/socialsRequest.dart';
import 'package:devstash/models/response/socialsResponse.dart';
import 'package:http/http.dart' as http;

class SocialServices {
  Future<SocialsResponse?> getSocials(String authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.socialsEndpoint);
      var headers = {'Authorization': authToken};

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return dataFromJson(response.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      log('Error during fetching: $error');
      throw Exception('An error occurred during fetching');
    }
  }

  Future<dynamic> updateSocials(
      String? authToken, SocialsRequest socials) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.socialsEndpoint);
      var headers = {'Authorization': authToken ?? " "};

      var response = await http.put(url,
          headers: headers, body: jsonEncode(socials.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      log('Error during fetching: $error');
      throw Exception('An error occurred during fetching');
    }
  }
}

SocialsResponse dataFromJson(String json) {
  final data = jsonDecode(json);

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
