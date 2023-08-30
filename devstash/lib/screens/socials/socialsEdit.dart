import 'dart:developer';

import 'package:devstash/models/request/skillRequest.dart';
import 'package:devstash/models/request/socialsRequest.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/services/SkillServices.dart';
import 'package:devstash/services/SocialServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialsEditScreen extends StatefulWidget {
  @override
  _SocialsEditScreenState createState() => _SocialsEditScreenState();
}

class _SocialsEditScreenState extends State<SocialsEditScreen> {
  TextEditingController _instagramController = TextEditingController();
  TextEditingController _githubController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        dynamic res = await SocialServices().getSocials(token);
        if (res['success']) {
          _instagramController.text = res['data'].instagram;
          _githubController.text = res['data'].github;
          _twitterController.text = res['data'].twitter;
          _linkedinController.text = res['data'].linkedin;
          _otherController.text = res['data'].other;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Socials'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(131, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "instagram.com/",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _instagramController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(131, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "github.com/",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _githubController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(131, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "twitter.com/",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _twitterController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(131, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "linkedin.in/",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _linkedinController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(131, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _otherController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "eg. Portfolior, Behance",
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _save() async {
    String instagram = _instagramController.text;
    String github = _githubController.text;
    String twitter = _twitterController.text;
    String linkedin = _linkedinController.text;
    String other = _otherController.text;
    SocialsRequest _socials = SocialsRequest(
        twitter: twitter,
        instagram: instagram,
        github: github,
        linkedin: linkedin,
        other: other);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      dynamic res = await SocialServices().updateSocials(token, _socials);
      Fluttertoast.showToast(
        msg: res['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: res['success'] ? Colors.green : Colors.red,
        textColor: Colors.white,
      );
      if (res['success']) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
