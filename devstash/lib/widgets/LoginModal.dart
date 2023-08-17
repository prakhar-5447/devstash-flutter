import 'dart:developer';

import 'package:devstash/models/request/signinRequest.dart';
import 'package:devstash/models/request/signupRequest.dart';
import 'package:devstash/models/response/LoginResponse.dart';
import 'package:devstash/providers/AuthProvider.dart';
import 'package:devstash/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginModal extends StatefulWidget {
  final Function(bool) changeForm;
  LoginModal({super.key, required this.changeForm});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameOrEmail =
      TextEditingController(text: "qwerty1234");
  TextEditingController _password = TextEditingController(text: "qwerty1234");
  AuthServices _authServices = AuthServices();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameOrEmail.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(50, 50),
            topRight: Radius.elliptical(50, 50)),
        color: Color.fromARGB(255, 241, 242, 246),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 25,
              bottom: 25,
            ),
            child: Text(
              "Login to your account",
              style: TextStyle(
                color: Color.fromARGB(255, 82, 81, 81),
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(50, 50),
                topRight: Radius.elliptical(50, 50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 30,
                left: 40,
                right: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                'assets/google.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                'assets/github.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              width: 45,
                              height: 45,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                'assets/linkedin.png',
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: 18,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                              color: Color.fromARGB(197, 144, 144, 144),
                              height: 25,
                              thickness: 1,
                              indent: 5,
                              endIndent: 5,
                            )),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  color: Color.fromARGB(197, 144, 144, 144),
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(197, 144, 144, 144),
                                height: 25,
                                thickness: 1,
                                indent: 5,
                                endIndent: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                            widget.changeForm(false);
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
                      height: 50,
                    )
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
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
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
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
