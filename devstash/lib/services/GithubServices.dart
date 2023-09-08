import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:devstash/env.dart';
import 'package:devstash/models/github/githubAuthenticationErrorResponse.dart';
import 'package:devstash/models/github/githubRepoContributerResponse.dart';
import 'package:devstash/models/github/githubRepoDataResponse.dart';
import 'package:devstash/models/github/githubRepoAssigneeResponse.dart';
import 'package:devstash/models/github/githubRepoIssueResponse.dart';
import 'package:devstash/models/github/githubRepoPullResponse.dart';
import 'package:devstash/models/github/githubTokenErrorResponse.dart';
import 'package:devstash/models/github/githubTokenRequest.dart';
import 'package:devstash/models/github/githubTokenResponse.dart';
import 'package:devstash/models/github/githubUserResponse.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GithubServices {
  Future<void> loginWithGitHub() async {
    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUrl&scope=read:user',
        callbackUrlScheme: scheme,
      );

      String authCode = Uri.parse(result).queryParameters['code'] ?? '';
      log(authCode.toString());
      String? accessToken;
      await Future.delayed(const Duration(milliseconds: 1000)).then((_) async {
        accessToken = await getToken(authCode);
      });

      if (accessToken != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('githubtoken', accessToken ?? '');
        log("Access Token: $accessToken");
      } else {
        log("Access token not retrieved");
      }
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        log('User canceled the login process.');
      } else {
        log('An error occurred: ${e.message}');
      }
    }
  }

  dynamic getToken(String authCode) async {
    try {
      final accessTokenResponse = await http.post(
        Uri.parse('https://github.com/login/oauth/access_token'),
        headers: {'Accept': 'application/json'},
        body: GithubTokenRequest(clientId, clientSecret, authCode, redirectUrl),
      );

      if (accessTokenResponse.statusCode == 200) {
        return githubTokenDataFromJson(accessTokenResponse.body, true);
      } else {
        return githubTokenDataFromJson(accessTokenResponse.body, false);
      }
    } catch (e) {
      log('An error occurred: $e');
      return null;
    }
  }

  dynamic getData(String? accessToken) async {
    final userResponse = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (userResponse.statusCode == 200) {
      return githubUserDataFromJson(userResponse.body, true);
    } else {
      return githubUserDataFromJson(userResponse.body, false);
    }
  }

  dynamic getRepoList(String? accessToken) async {
    final repoResponse = await http.get(
      Uri.parse('https://api.github.com/user/repos'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (repoResponse.statusCode == 200) {
      return githubRepoListDataFromJson(repoResponse.body, true);
    } else {
      return githubRepoListDataFromJson(repoResponse.body, false);
    }
  }

  dynamic getRepoLanguages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? repoName = prefs.getString('repository') ?? 'devstash-flutter';
    String? owner = prefs.getString('owner') ?? 'prakhar-5447';
    String? accessToken = prefs.getString('githubtoken');

    final apiUrl = 'https://api.github.com/repos/$owner/$repoName/languages';

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };

    final contributerResponse =
        await http.get(Uri.parse(apiUrl), headers: headers);

    if (contributerResponse.statusCode == 200) {
      return githubRepoLanguagesDataFromJson(contributerResponse.body, true);
    } else {
      return githubRepoContributerListDataFromJson(
          contributerResponse.body, false);
    }
  }

  dynamic getRepoContributors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? repoName = prefs.getString('repository') ?? 'devstash-flutter';
    String? owner = prefs.getString('owner') ?? 'prakhar-5447';
    String? accessToken = prefs.getString('githubtoken');

    final apiUrl = 'https://api.github.com/repos/$owner/$repoName/contributors';

    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };

    final contributerResponse =
        await http.get(Uri.parse(apiUrl), headers: headers);

    if (contributerResponse.statusCode == 200) {
      return githubRepoContributerListDataFromJson(
          contributerResponse.body, true);
    } else {
      return githubRepoContributerListDataFromJson(
          contributerResponse.body, false);
    }
  }

  dynamic getRepoIssue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? repoName = prefs.getString('repository') ?? 'devstash-flutter';
    String? owner = prefs.getString('owner') ?? 'prakhar-5447';
    String? state = 'open';

    final apiUrl =
        'https://api.github.com/repos/$owner/$repoName/issues?state=$state';

    final headers = {
      'Accept': 'application/json',
    };

    final issueResponse = await http.get(Uri.parse(apiUrl), headers: headers);
    if (issueResponse.statusCode == 200) {
      return githubRepoIssueDataFromJson(issueResponse.body, true);
    } else {
      return githubRepoIssueDataFromJson(issueResponse.body, false);
    }
  }

  dynamic getRepoPull() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? repoName = prefs.getString('repository') ?? 'devstash-flutter';
    String? owner = prefs.getString('owner') ?? 'prakhar-5447';
    String? state = 'open';

    final apiUrl =
        'https://api.github.com/repos/$owner/$repoName/pulls?state=$state';

    final headers = {
      'Accept': 'application/json',
    };

    final pullResponse = await http.get(Uri.parse(apiUrl), headers: headers);

    if (pullResponse.statusCode == 200) {
      return githubRepoPullDataFromJson(pullResponse.body, true);
    } else {
      return githubRepoPullDataFromJson(pullResponse.body, false);
    }
  }
}

dynamic githubTokenDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    GithubTokenResponse data = GithubTokenResponse(githubData['access_token'],
        githubData['token_type'], githubData['scope']);
    return {"success": success, "data": data};
  } else {
    GithubTokenErrorResponse data = GithubTokenErrorResponse(
        githubData['error'],
        githubData['error_description'],
        githubData['error_uri']);
    return {"success": success, "data": data};
  }
}

dynamic githubUserDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    GithubUserResponse data = GithubUserResponse(
        githubData['id'].toString(),
        githubData['login'],
        githubData['name'],
        githubData['avatar_url'],
        githubData['bio'],
        githubData['public_repos'].toString(),
        githubData['followers'].toString(),
        githubData['following'].toString());
    return {"success": success, "data": data};
  } else {
    GithubAuthenticationErrorResponse data = GithubAuthenticationErrorResponse(
        githubData['message'], githubData['documentation_url']);
    return {"success": success, "data": data};
  }
}

dynamic githubRepoListDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    List<GithubRepoDataResponse> data = [];

    for (var repo in githubData) {
      final repository = GithubRepoDataResponse(repo['id'], repo['name']);
      data.add(repository);
    }
    return {"success": success, "data": data};
  } else {
    GithubAuthenticationErrorResponse data = GithubAuthenticationErrorResponse(
        githubData['message'], githubData['documentation_url']);
    return {"success": success, "data": data};
  }
}

dynamic githubRepoContributerListDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    List<GithubRepoContributerResponse> data = [];

    for (var user in githubData) {
      final contributer = GithubRepoContributerResponse(
          user['id'].toString(),
          user['login'],
          user['avatar_url'],
          user['url'],
          user['contributions'].toString());
      data.add(contributer);
    }
    return {"success": success, "data": data};
  } else {
    GithubAuthenticationErrorResponse data = GithubAuthenticationErrorResponse(
        githubData['message'], githubData['documentation_url']);
    return {"success": success, "data": data};
  }
}

dynamic githubRepoLanguagesDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    return {"success": success, "data": githubData};
  } else {
    GithubAuthenticationErrorResponse data = GithubAuthenticationErrorResponse(
        githubData['message'], githubData['documentation_url']);
    return {"success": success, "data": data};
  }
}

dynamic githubRepoIssueDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    List<GithubRepoIssueResponse> data = [];

    for (var user in githubData) {
      final login = GithubRepoAssigneeResponse(
          user['user']['id'].toString(),
          user['user']['login'],
          user['user']['avatar_url'],
          user['user']['url']);
      final issue = GithubRepoIssueResponse(
          user['id'].toString(),
          user['number'].toString(),
          user['title'],
          login,
          assigneeDataFromJson(user['assignees']),
          user['html_url']);
      data.add(issue);
    }
    return {"success": success, "data": data};
  } else {
    GithubAuthenticationErrorResponse data = GithubAuthenticationErrorResponse(
        githubData['message'], githubData['documentation_url']);
    return {"success": success, "data": data};
  }
}

dynamic githubRepoPullDataFromJson(String json, bool success) {
  final githubData = jsonDecode(json);
  if (success) {
    List<GithubRepoPullResponse> data = [];

    for (var user in githubData) {
      final login = GithubRepoAssigneeResponse(
          user['user']['id'].toString(),
          user['user']['login'],
          user['user']['avatar_url'],
          user['user']['url']);
      final pull = GithubRepoPullResponse(user['id'].toString(),
          user['number'].toString(), user['title'], login, user['html_url']);
      data.add(pull);
    }
    return {"success": success, "data": data};
  } else {
    GithubAuthenticationErrorResponse data = GithubAuthenticationErrorResponse(
        githubData['message'], githubData['documentation_url']);
    return {"success": success, "data": data};
  }
}

dynamic assigneeDataFromJson(dynamic userData) {
  List<GithubRepoAssigneeResponse> data = [];
  for (var user in userData) {
    final assignee = GithubRepoAssigneeResponse(
        user['id'].toString(), user['login'], user['avatar_url'], user['url']);
    data.add(assignee);
  }
  return data;
}
