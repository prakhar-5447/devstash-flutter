import 'dart:developer';

import 'package:devstash/controllers/auth_controller.dart';
import 'package:devstash/models/request/signinRequest.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/screens/HomeScreen.dart';
import 'package:devstash/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModalContent extends StatefulWidget {
  const LoginModalContent({super.key});

  @override
  State<LoginModalContent> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModalContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameOrEmail =
      TextEditingController(text: "qwerty1234");
  final TextEditingController _password =
      TextEditingController(text: "qwerty1234");
  final AuthServices _authServices = AuthServices();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _usernameOrEmail.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login to your account",
              style: TextStyle(
                color: Color.fromARGB(255, 82, 81, 81),
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter valid email or username';
                          }
                          return null;
                        },
                        controller: _usernameOrEmail,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter strong password';
                          }
                          return null;
                        },
                        controller: _password,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Forgot passsword?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 117, 140, 253),
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 15),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 33, 149, 221))),
                      onPressed: _isLoading ? null : _performLogin,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Padding(
                              padding: EdgeInsets.only(
                                  left: 50, top: 12, right: 50, bottom: 12),
                              child: Text(
                                "REGISTER",
                                style: TextStyle(
                                    color: Color.fromARGB(221, 221, 215, 215),
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromARGB(197, 144, 144, 144),
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.find<ModalController>().changeForm(false);
                        },
                        child: const Text(
                          "Register here",
                          style: TextStyle(
                              color: Color.fromARGB(255, 24, 178, 250),
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
    }

    final usernameOrEmail = _usernameOrEmail.text;
    final password = _password.text;
    SigninRequest signinData = SigninRequest(usernameOrEmail, password);

    try {
      dynamic res = await _authServices.signinUser(signinData);
      if (res["success"]) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.setToken(res["data"].token);
        authProvider.setUser(res["data"].user);
        Navigator.pushReplacementNamed(context, '/');
      }
      Fluttertoast.showToast(
        msg: res["msg"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: res["success"] ? Colors.green : Colors.red,
        textColor: Colors.white,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', res["data"].token);
      Get.off(HomeScreen());
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Invalid username or password';
        _usernameOrEmail.clear();
        _password.clear();
        _isLoading = false;
      });
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
