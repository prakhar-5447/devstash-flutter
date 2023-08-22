import 'package:devstash/controllers/auth_controller.dart';
import 'package:devstash/models/request/signinRequest.dart';
import 'package:devstash/screens/HomeScreen.dart';
import 'package:devstash/screens/auth/signup_modal.dart';
import 'package:devstash/services/AuthServices.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModalContent extends StatelessWidget {
  LoginModalContent({Key? key}) : super(key: key);

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
                          border: OutlineInputBorder(),
                          labelText: 'Username/Email',
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
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot passsword?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 117, 140, 253),
                                fontSize: 12,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.right,
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
                                      "LOGIN",
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

      final usernameOrEmail = _usernameOrEmail.text;
      final password = _password.text;
      SigninRequest signinData = SigninRequest(usernameOrEmail, password);
      try {
        dynamic res = await _authServices.signinUser(signinData);
        Fluttertoast.showToast(
          msg: res["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: res["success"] ? Colors.green : Colors.red,
          textColor: Colors.white,
        );
        if (res["success"]) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', res["data"].token);
          Get.off(() => HomeScreen());
          _isLoading.value = false;
        }
      } catch (error) {
        _errorMessage = 'Invalid username or password';
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
