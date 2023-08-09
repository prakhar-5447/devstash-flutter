import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/contactRequest.dart';
import 'package:devstash/models/response/contactResponse.dart';
import 'package:devstash/models/response/education.dart';
import 'package:http/http.dart' as http;

class ContactServices {
  Future<dynamic> updateContact(
      ContactRequest contact, String? authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.contactEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(contact.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ContactResponse?> getContact(String? authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.contactEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return contactFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  ContactResponse contactFromJson(String jsonData) {
    final json = jsonDecode(jsonData);
    String id = json['ID'];
    String userId = json['UserId'];
    String city = json['City'];
    String state = json['State'];
    String country = json['Country'];
    String countryCode = json['CountryCode'];
    String phoneNo = json['PhoneNo'];
    ContactResponse contact = ContactResponse(
        id: id,
        userid: userId,
        city: city,
        state: state,
        country: country,
        countryCode: countryCode,
        phoneNo: phoneNo);
    return contact;
  }
}
