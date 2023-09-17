import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/contactRequest.dart';
import 'package:devstash/models/response/contactResponse.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/services/Helper.dart';
import 'package:http/http.dart' as http;

class ContactServices {
  dynamic updateContact(ContactRequest contact, String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.contactEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(contact.toJson()));
      return Helper().responseFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
  }

  dynamic getContact(String token) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.contactEndpoint);
      var headers = {
        'Authorization': token,
      };
      var response = await http.get(
        url,
        headers: headers,
      );
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
    ContactResponse contact = contactFromJson(json);
    return {"success": success, "msg": msg, "data": contact};
  }

  return {"success": success, "msg": msg, "data": {}};
}

ContactResponse contactFromJson(String jsonData) {
  final json = jsonDecode(jsonData)['data'];
  String id = json['ID'];
  String userId = json['UserId'];
  String city = json['City'];
  String state = json['State'];
  String country = json['Country'];
  String countryCode = json['CountryCode'];
  String phoneNo = json['PhoneNo'];
  ContactResponse contact =
      ContactResponse(id, userId, city, state, country, countryCode, phoneNo);
  return contact;
}
