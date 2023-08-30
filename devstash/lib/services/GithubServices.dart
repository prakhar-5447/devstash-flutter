import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GithubServices {
  Future<String?> getToken(String? authCode) async {
    log("first");
    try {
      final accessTokenResponse = await http.post(
        Uri.parse('https://github.com/login/oauth/access_token'),
        headers: {'Accept': 'application/json'},
        body: {
          'client_id': Env.clientId,
          'client_secret': Env.clientSecret,
          'code': authCode,
          'redirect_uri': Env.redirectUrl,
        },
      );
      log("second");

      if (accessTokenResponse.statusCode == 200) {
        final accessToken =
            json.decode(accessTokenResponse.body)['access_token'];
        log("third");
        return accessToken;
      } else {
        log('Failed to get access token: ${accessTokenResponse.statusCode}');
        return null;
      }
    } catch (e) {
      log('An error occurred: $e');
      return null;
    }
  }

  Future<void> loginWithGitHub() async {
    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://github.com/login/oauth/authorize?client_id=${Env.clientId}&redirect_uri=${Env.redirectUrl}&scope=read:user',
        callbackUrlScheme: Env.scheme,
      );

      String? authCode = Uri.parse(result).queryParameters['code'];
      log(authCode.toString());
      String? accessToken;
      await Future.delayed(const Duration(milliseconds: 1000)).then((_) async {
        accessToken = await getToken(authCode);
      });

      if (accessToken != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('githubtoken', accessToken ?? '');
        log("Access Token: $accessToken");
        // Proceed with further API calls or UI updates
      } else {
        log("Access token not retrieved");
        // Handle the case where the access token retrieval failed.
      }
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        log('User canceled the login process.');
      } else {
        log('An error occurred: ${e.message}');
      }
    }
  }

  Future<List<dynamic>?> getData(String? accessToken) async {
    final userResponse = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (userResponse.statusCode == 200) {
      final userDetails = json.decode(userResponse.body);

      log('User Details: $userDetails');

      final reposResponse = await http.get(
        Uri.parse('https://api.github.com/user/repos'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      if (reposResponse.statusCode == 200) {
        final repos = json.decode(reposResponse.body);
        log(repos.toString());
        return repos;
      } else {
        log('Failed to get repositories: ${reposResponse.statusCode}');
      }
    } else {
      log('Failed to get user details: ${userResponse.statusCode}');
    }
    return [];
  }
}
