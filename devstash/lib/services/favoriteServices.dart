import 'dart:convert';
import 'dart:developer';

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
}

FavoriteResponse favoriteFromJson(String json) {
  final favoriteData = jsonDecode(json);
  String userId = favoriteData['UserId'];
  List<String> projectIds = List<String>.from(favoriteData['ProjectIds']);

  FavoriteResponse favorite = FavoriteResponse(userId, projectIds);

  return favorite;
}
