import 'dart:convert';
import 'dart:developer';

import 'package:devstash/models/response/userResponse.dart';
import 'package:http/http.dart' as http;
import 'package:devstash/constants.dart';

class UserServices {
  Future<UserResponse?> getUser() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getUserEndpoint);
      var headers = {
        'Authorization':
            'v2.local.tN3JYuKCqQgZTQuTEAYTzcI58bOb23EO5MdIMZPbO6IWDjGbr93tnFWBkKtB95BbAEycczByqEhJB8VLj13cVs44tlKF6Km1c_DzMkSjtXc_bKY_Wysh7rbPh87eHpDR-WheHigRLHS89OGmGReGcohUIdlgRu1SduSu15ZD-Xnr-TzM_m-P8CI7ahQYaY1bJDShaG8W9sU0lpYoLi_-q0L1-4arnGMdiWEDdHZ8l-euU4QMbpf-QCrzvoMbxlkj6Cx2n2qQ3Z-_8Bp3ee1zz_15mw4OZ4dscKGkJrSxBlJuHDmysdGrz2Qp1m5k9czt.bnVsbA',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        UserResponse user = userFromJson(response.body);
        return user;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

UserResponse userFromJson(String json) {
  final userData = jsonDecode(json);

  String id = userData['ID'];
  String name = userData['Name'];
  String avatar = userData['Avatar'];
  String username = userData['Username'];
  String password = userData['Password'];
  String email = userData['Email'];
  String phone = userData['Phone'];
  String description = userData['Description'];

  UserResponse user = UserResponse(
    id,
    name,
    avatar,
    username,
    password,
    email,
    phone,
    description,
  );

  return user;
}
