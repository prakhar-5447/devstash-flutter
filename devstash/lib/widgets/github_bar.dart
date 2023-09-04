import 'dart:developer';

import 'package:devstash/services/GithubServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GithubOAuthScreen extends StatefulWidget {
  @override
  _GithubOAuthScreenState createState() => _GithubOAuthScreenState();
}

class _GithubOAuthScreenState extends State<GithubOAuthScreen> {
  List<dynamic> _repositories = [];
  final GithubServices githubServices = GithubServices();
  late String token;

  @override
  void initState() {
    super.initState();
    get();
  }

  void _githubLogin() {
    githubServices.loginWithGitHub();
  }

  void _gettoken() {
    githubServices.getToken(token);
  }

  void _getdata() async {
    List<dynamic>? repos = await githubServices.getData(token);
    if (repos != null) {
      setState(() {
        _repositories = repos;
      });
    }
  }

  void get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('githubtoken') ?? '';
  }

  String? authCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub OAuth')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _githubLogin,
              child: const Text('Login with GitHub'),
            ),
            ElevatedButton(
              onPressed: _gettoken,
              child: const Text('Get User'),
            ),
            ElevatedButton(
              onPressed: _getdata,
              child: const Text('Get Data'),
            ),
            const SizedBox(height: 16),
            if (_repositories.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _repositories.length,
                  itemBuilder: (context, index) {
                    final repo = _repositories[index];
                    return ListTile(
                      title: Text(repo['name']),
                      subtitle: Text(repo['description'] ?? ''),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
