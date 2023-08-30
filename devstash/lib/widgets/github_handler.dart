import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetailsPage extends StatefulWidget {
  final String accessToken;

  UserDetailsPage({required this.accessToken});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final userData = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(userData['avatar_url']),
              Text('Username: ${userData['login']}'),
              Text('Name: ${userData['name']}'),
              Text('Bio: ${userData['bio']}'),
              // Display other user details as needed
            ],
          );
        }
      },
    );
  }
}
