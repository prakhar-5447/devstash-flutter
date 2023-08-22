import 'package:devstash/controllers/user_controller.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/user_state.dart';
import 'package:devstash/screens/home/home_screen.dart';
import 'package:devstash/services/AuthServices.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:devstash/controllers/password_controller.dart';
import 'package:devstash/widgets/PasswordStrengthBar.dart';

class SignupModalContent extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final PasswordController _controller = Get.put(PasswordController());

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
                            RegExp('[a-zA-Z0-9_]'),
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
                      const SizedBox(
                        height: 15,
                      ),
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
                      const SizedBox(
                        height: 15,
                      ),
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
                        controller: _email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
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
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 150,
                          child: Obx(
                            () => PasswordStrengthBar(
                              strength: _controller.passwordStrength.value,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(
                                        255,
                                        33,
                                        149,
                                        221,
                                      ),
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
                                      "REGISTER",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(221, 221, 215, 215),
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22,
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
      final username = _username.text;
      final password = _password.text;
      final name = _name.text;
      final email = _email.text;
      SignupRequest signupdata = SignupRequest(name, username, email, password);
      try {
        dynamic res = await _authServices.signupUser(signupdata);
        if (res["success"]) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', res["data"].token);
          UserState userData = res["data"].user;
          Get.find<UserController>().user = userData;
          Get.off(() => const HomeScreen());
        }
        _isLoading.value = false;
        Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
          textColor: Colors.white,
        );
      } catch (error) {
        _errorMessage = 'Invalid username or password';
        _username.clear();
        _password.clear();
        _password.clear();
        _controller.updatePasswordStrength(_password.text);
        _email.clear();
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

class SingleSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final trimmedValue = newValue.text.replaceAll(RegExp(r'\s+'), ' ');
    return TextEditingValue(
      text: trimmedValue,
      selection: TextSelection.collapsed(offset: trimmedValue.length),
    );
  }
}
