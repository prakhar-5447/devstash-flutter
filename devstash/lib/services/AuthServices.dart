import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/loginRequest.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class AuthServices {
  Future<String?> loginUser(LoginRequest loginData) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);

      var response = await http.post(url, body: jsonEncode(loginData.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
