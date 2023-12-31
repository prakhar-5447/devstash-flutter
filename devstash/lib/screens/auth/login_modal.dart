import 'dart:developer';

import 'package:devstash/binding_screens.dart';
import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/models/request/signinRequest.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/screens/auth/signup_modal.dart';
import 'package:devstash/services/AuthServices.dart';
import 'package:devstash/services/firebaseServices.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModalContent extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameOrEmail =
      TextEditingController(text: "qwerty1234");
  final TextEditingController _password =
      TextEditingController(text: "qwerty1234");

  final AuthServices _authServices = AuthServices();

  final formatter = SingleSpaceInputFormatter();
  final RxBool _isLoading = false.obs;
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
          children: [
            const Text(
              "Welcome\nBack",
              style: TextStyle(
                color: Color.fromARGB(255, 82, 81, 81),
                fontWeight: FontWeight.w600,
                height: 1.2,
                fontSize: 30,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 30,
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
                            RegExp('[a-zA-Z0-9_@.]'),
                          ),
                          formatter
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your email';
                          }
                          if (value.contains('@') &&
                              value.indexOf('@') == value.lastIndexOf('@')) {
                            if (!EmailValidator.validate(value)) {
                              return 'invalid email';
                            }
                          }
                          return null;
                        },
                        controller: _usernameOrEmail,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Username/Email',
                          isDense: true,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                          return null;
                        },
                        controller: _password,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          isDense: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot passsword?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 117, 140, 253),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 15,
                      ),
                      child: Obx(
                        () {
                          return _isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 5, 66, 157),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed:
                                      _isLoading.value ? null : _performLogin,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
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
      _isLoading.value = true;
      _errorMessage = '';

      final usernameOrEmail = _usernameOrEmail.text;
      final password = _password.text;
      FirebaseServices firebaseServices = FirebaseServices();
      String? fcmtoken = await firebaseServices.getFCMToken();
      SigninRequest signinData =
          SigninRequest(usernameOrEmail, password, fcmtoken ?? '');
      try {
        dynamic res = await _authServices.signinUser(signinData);
        if (res["success"]) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', res["data"].token);
          UserState userData = res["data"].user;
          Get.find<UserController>().user = userData;
          Get.off(() => BindingScreen());
        }

        Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
          textColor: Colors.white,
        );
        _isLoading.value = false;
      } catch (error) {
        log(error.toString());
        _errorMessage = '$error';
        _usernameOrEmail.clear();
        _password.clear();
        _isLoading.value = false;
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
}
