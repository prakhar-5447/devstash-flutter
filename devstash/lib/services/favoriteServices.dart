import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/favoriteRequest.dart';
import 'package:devstash/models/response/favoriteResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class FavoriteServices {
  Future<FavoriteResponse?> getFavorite(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.favoriteEndpoint);
      var headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        FavoriteResponse favorite = favoriteFromJson(response.body);
        return favorite;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> checkFavorite(String token, String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.checkfavoriteEndpoint + id);
      var headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<dynamic> updateFavorite(FavoriteRequest favorite, String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.favoriteEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(favorite.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

FavoriteResponse favoriteFromJson(String json) {
  final favoriteData = jsonDecode(json);
  String userId = favoriteData['UserId'];
  List<String> projectIds = List<String>.from(favoriteData['ProjectIds']);

  FavoriteResponse favorite = FavoriteResponse(userId, projectIds);

  return favorite;
}
