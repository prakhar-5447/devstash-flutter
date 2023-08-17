import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/request/bookmarkRequest.dart';
import 'package:devstash/models/response/bookmarkResponse.dart';
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

  Future<dynamic> updateBookmark(BookmarkRequest bookmark) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.bookmarkEndpoint);
      var headers = {
        'Authorization':
            'v2.local.XTqynB9B5DI6C6kEd-ouwrjJoZzT-rMq7Fnaw4IKdgIy7AtHUCg5Bx50Hruf9rh3D1NG45U5W1JOWwsTXMydhAKNVmGt8ikRC250GzS4oGf5gSE89rXYPFASP6SbWY8wBMGu2kn7KgiHm9EI4_P2EVDgudM23Z6RVDGU1JboZB7fUJzyVf09Z0BxFdUXXX0UuSKXuIHpu6mhNR41WFSVo0IgRlbY3LRTW15v6nxwy6LjUCd_A9ocbaVpo5y0c9orsgJvbOq3n4xIxYOb0kA4IvzGYjy0jdhIAXzUFp2Agc1F2Y_tSZ0q96QejzUaZ5N1.bnVsbA',
      };

      var response = await http.put(url,
          headers: headers, body: jsonEncode(bookmark.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
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
  final bookmarkData = jsonDecode(json)['bookmark'];

  String userId = bookmarkData['UserId'];
  List<String> otherUserIds = List<String>.from(bookmarkData['OtherUserIds']);

  BookmarkResponse bookmark = BookmarkResponse(userId, otherUserIds);

  return bookmark;
}
