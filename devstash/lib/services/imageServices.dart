import 'dart:convert';
import 'dart:developer';
import 'package:devstash/models/request/projectRequest.dart';
import 'package:devstash/models/response/CollaboratorResponse.dart';
import 'package:devstash/models/response/projectResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  Future<String?> addImage(XFile image) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.uploadEndpoint);
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(await response.stream.bytesToString());
        final String imageName = responseData['image_url'];
        return imageName;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<List<ProjectResponse>?> getImage(String token) async {
  //   try {
  //     var url =
  //         Uri.parse(ApiConstants.baseUrl + ApiConstants.getProjectsEndpoint);
  //     var headers = {
  //       'Authorization': token,
  //     };

  //     var response = await http.get(url, headers: headers);
  //     if (response.statusCode == 200) {
  //       List<ProjectResponse> project = response.body;
  //       return project;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
