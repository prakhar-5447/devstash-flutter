import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/response/bookmarkResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class BookmarkServices {
  Future<BookmarkResponse?> getBookmark() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.bookmarkEndpoint);
      var headers = {
        'Authorization':
            'v2.local.Gdj7OTm8jFjgmU6D-Mqoy4YboGlJA6CC1ytk2jMQsoORoBVdR-iIGx-MW4Xd603RkHbpQFDRtB1tNXRnETyiD4FyirXUuExgZGC2lHvRlb-AlcUikcWsd1_AiBm7cwYBY0tggGJeB7qsf-HsjrvggDZjSP9H276i3mBIAiyYmvtDu7WOE8mi1Em-uEPLNt1vOK5ABCnNSylZiz42wzhiI7oO3m6Wbu_AOQgeydBkesx0-4pCu0wNWBgbg_fTzxcc0fJpyKf0tee_sbfu2Pw90s0SyLr2mnoiStv5dkAfEJlu_I29cD1sMzF1VJLUsBCw.bnVsbA',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        BookmarkResponse bookmark = bookmarkFromJson(response.body);
        return bookmark;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

BookmarkResponse bookmarkFromJson(String json) {
  final bookmarkData = jsonDecode(json);

  String userId = bookmarkData['UserId'];
  List<String> otherUserIds = List<String>.from(bookmarkData['OtherUserIds']);

  BookmarkResponse bookmark = BookmarkResponse(userId, otherUserIds);

  return bookmark;
}
