import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/favoriteRequest.dart';
import 'package:devstash/models/response/favoriteResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class FavoriteServices {
  Future<FavoriteResponse?> getFavorite() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.favoriteEndpoint);
      var headers = {
        'Authorization':
            'v2.local.Gdj7OTm8jFjgmU6D-Mqoy4YboGlJA6CC1ytk2jMQsoORoBVdR-iIGx-MW4Xd603RkHbpQFDRtB1tNXRnETyiD4FyirXUuExgZGC2lHvRlb-AlcUikcWsd1_AiBm7cwYBY0tggGJeB7qsf-HsjrvggDZjSP9H276i3mBIAiyYmvtDu7WOE8mi1Em-uEPLNt1vOK5ABCnNSylZiz42wzhiI7oO3m6Wbu_AOQgeydBkesx0-4pCu0wNWBgbg_fTzxcc0fJpyKf0tee_sbfu2Pw90s0SyLr2mnoiStv5dkAfEJlu_I29cD1sMzF1VJLUsBCw.bnVsbA',
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

  Future<dynamic> updateFavorite(FavoriteRequest favorite) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.favoriteEndpoint);
      var headers = {
        'Authorization':
            'v2.local.XTqynB9B5DI6C6kEd-ouwrjJoZzT-rMq7Fnaw4IKdgIy7AtHUCg5Bx50Hruf9rh3D1NG45U5W1JOWwsTXMydhAKNVmGt8ikRC250GzS4oGf5gSE89rXYPFASP6SbWY8wBMGu2kn7KgiHm9EI4_P2EVDgudM23Z6RVDGU1JboZB7fUJzyVf09Z0BxFdUXXX0UuSKXuIHpu6mhNR41WFSVo0IgRlbY3LRTW15v6nxwy6LjUCd_A9ocbaVpo5y0c9orsgJvbOq3n4xIxYOb0kA4IvzGYjy0jdhIAXzUFp2Agc1F2Y_tSZ0q96QejzUaZ5N1.bnVsbA',
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
