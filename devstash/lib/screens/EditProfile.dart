import 'dart:developer';

import 'package:devstash/models/request/UserProfile.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/ProfileScreen.dart';
import 'package:devstash/screens/socialsEdit.dart';
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
    final provider = Provider.of<AuthProvider>(context, listen: false);
    if (provider.user != null) {
<<<<<<< HEAD
      _nameController.text = provider.user!.name;
      _usernameController.text = provider.user!.username;
      _descriptionController.text = provider.user!.description;
      _emailController.text = provider.user!.email;
=======
      _nameController.text = provider.user!.Name;
      _usernameController.text = provider.user!.Username;
      _descriptionController.text = provider.user!.Description;
      _emailController.text = provider.user!.Email;
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
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
      final provider = Provider.of<AuthProvider>(context, listen: false);
<<<<<<< HEAD
      dynamic _user =
          await _userServices.updateProfile(userprofile, provider.token);
      log(_user.toString());
      if (provider.token != null) {
        UserState? _userData = await _userServices.getUser(provider.token);
        provider.setUser(_userData);
=======
      String? token = provider.token;
      if (token != null) {
        dynamic res = await _userServices.updateProfile(userprofile, token);
        dynamic userResponse = await _userServices.getUser(token);
        if (res["success"]) {
          if (userResponse["success"]) {
            provider.setUser(userResponse["data"]);
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
>>>>>>> fcdd3faa197ea6a6d4b0c5fbae6d3d4a3a11e17c
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
