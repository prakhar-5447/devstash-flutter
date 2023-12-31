import 'dart:developer';

import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/models/request/UserProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/profile/ProfileScreen.dart';
import 'package:devstash/screens/socials/socialsEdit.dart';
import 'package:devstash/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  UserServices _userServices = UserServices();

  @override
  void initState() {
    super.initState();
    final UserController userController = Get.find<UserController>();
    final UserState? user = userController.user;
    if (user != null) {
      _nameController.text = user.name;
      _usernameController.text = user.username;
      _descriptionController.text = user.description;
      _emailController.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialsEditScreen()),
                );
              },
              icon: const Icon(
                Icons.link,
                size: 15,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'UserName',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _saveProfileDetails,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfileDetails() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String username = _usernameController.text;

    UserProfile userprofile = UserProfile(
        name: name, username: username, description: description, email: email);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        dynamic res = await _userServices.updateProfile(userprofile, token);
        dynamic userResponse = await _userServices.getUser(token);
        if (res["success"]) {
          if (userResponse["success"]) {
          Get.find<UserController>().user = userResponse['data'];
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
          Fluttertoast.showToast(
            msg: userResponse["msg"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor:
                userResponse["success"] ? Colors.green : Colors.red,
            textColor: Colors.white,
          );
        }
        Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
          textColor: Colors.white,
        );
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
