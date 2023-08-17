import 'dart:developer';

import 'package:devstash/controllers/auth_controller.dart';
import 'package:devstash/models/request/signinRequest.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:devstash/controllers/password_controller.dart';
import 'package:devstash/widgets/PasswordStrengthBar.dart';

class SignupModalContent extends StatelessWidget {
  SignupModalContent({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final PasswordController _controller = Get.put(PasswordController());
  final formatter = SingleSpaceInputFormatter();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Create\nAccount",
              style: TextStyle(
                color: Color.fromARGB(255, 82, 81, 81),
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                height: 1.2,
                fontSize: 30,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 25,
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
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9]'),
                          ),
                          formatter
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter valid username';
                          }
                          return null;
                        },
                        controller: _username,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]'),
                          ),
                          formatter
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your name';
                          }
                          return null;
                        },
                        controller: _name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9@.]'),
                          ),
                          formatter
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter valid ${_name.text}';
                          }
                          if (value.contains('@') &&
                              value.indexOf('@') == value.lastIndexOf('@')) {
                            if (!EmailValidator.validate(value)) {
                              return 'invalid email';
                            }
                          } else {
                            return 'invalid email';
                          }
                          return null;
                        },
                        controller: _email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9@]'),
                          ),
                          formatter
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter strong password';
                          }
                          if (_controller.passwordStrength < 0.5) {
                            return 'password is too weak';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _controller.updatePasswordStrength(_password.text);
                        },
                        controller: _password,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 150,
                          child: Obx(() => PasswordStrengthBar(
                                strength: _controller.passwordStrength.value,
                              )),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 33, 149, 221)),
                        ),
                        onPressed: _isLoading ? null : _performLogin,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Padding(
                                padding: EdgeInsets.only(
                                  left: 50,
                                  top: 12,
                                  right: 50,
                                  bottom: 12,
                                ),
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                    color: Color.fromARGB(221, 221, 215, 215),
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22,
                                  ),
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
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.find<ModalController>().changeForm(true);
                          },
                          child: const Text(
                            "Register here",
                            style: TextStyle(
                              color: Color.fromARGB(255, 24, 178, 250),
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      _errorMessage = '';
    }

    final usernameOrEmail = _username.text;
    final password = _password.text;
    SigninRequest loginData = SigninRequest(usernameOrEmail, password);
    try {
      // dynamic _user = await _authServices.loginUser(loginData);
      // final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // authProvider.setToken(_user.token);
      // authProvider.setUser(_user.user);
      Fluttertoast.showToast(
        msg: "Successfully Login",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', _user.token);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      // );
    } catch (error) {
      log(error.toString());
      _errorMessage = 'Invalid username or password';
      _username.clear();
      _password.clear();
      _isLoading = false;
      Fluttertoast.showToast(
        msg: _errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

class SingleSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Replace any sequence of spaces with a single space
    final trimmedValue = newValue.text.replaceAll(RegExp(r'\s+'), ' ');

    return TextEditingValue(
      text: trimmedValue,
      selection: TextSelection.collapsed(offset: trimmedValue.length),
    );
  }
}
