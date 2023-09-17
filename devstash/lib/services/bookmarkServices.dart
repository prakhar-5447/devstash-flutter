import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/bookmarkRequest.dart';
import 'package:devstash/models/response/bookmarkResponse.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class BookmarkServices {
  dynamic getBookmark(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.bookmarkEndpoint);
      var headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);
      return dataFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic updateBookmark(String token, BookmarkRequest bookmark) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.bookmarkEndpoint);
      var headers = {'Authorization': token};

      var response = await http.put(url,
          headers: headers, body: jsonEncode(bookmark.toJson()));
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}

dynamic dataFromJson(String json) {
  final authData = jsonDecode(json);
  bool success = authData['success'];
  String msg = authData['msg'];
  if (success) {
    BookmarkResponse bookmark = bookmarkFromJson(json);
    return {"success": success, "msg": msg, "data": bookmark};
  }

  return {"success": success, "msg": msg, "data": {}};
}

BookmarkResponse bookmarkFromJson(String json) {
  final bookmarkData = jsonDecode(json)['data'];

  String userId = bookmarkData['UserId'];
  List<String> otherUserIds = List<String>.from(bookmarkData['OtherUserIds']);

  BookmarkResponse bookmark = BookmarkResponse(userId, otherUserIds);

  return bookmark;
}
