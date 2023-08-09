import 'dart:convert';
import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/socialsRequest.dart';
import 'package:devstash/models/response/socialsResponse.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AvatarServices {
  Future<dynamic> updateAvatar(String? authToken, XFile image) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.avatarEndpoint);
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = authToken ?? ""
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      log('Error during fetching: $error');
    }
  }
}