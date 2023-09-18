import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:devstash/models/response/messageResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class MessageServices {
  dynamic getMessage(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.messageEndpoint);
      var headers = {
        'Authorization': token,
      };

      var response = await http.get(url, headers: headers);
      return dataFromJson(response.body);
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
    List<MessageResponse> messages = messageFromJson(json);
    return {"success": success, "msg": msg, "data": messages};
  }

  return {"success": success, "msg": msg, "data": {}};
}

List<MessageResponse> messageFromJson(String json) {
  final messgaeData = jsonDecode(json)['data'];
  List<MessageResponse> messageList = [];

  for (var message in messgaeData) {
    String dateString = message['CreatedAt'];
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat.yMMMd().format(dateTime);
    MessageResponse messageInfo = MessageResponse(
        message['ID'],
        message['UserId'],
        message['Subject'],
        message['Description'],
        message['SenderName'],
        message['SenderEmail'],
        formattedDate);
    messageList.add(messageInfo);
  }
  return messageList;
}
