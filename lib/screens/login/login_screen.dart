import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih_frontend/utils/api_functions.dart';

import 'package:sih_frontend/utils/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPressed = false;
  bool fillForm = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cmpController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController phnoController = TextEditingController();

  FocusNode passwordFocus = FocusNode();
  FocusNode passwordConfirmFocus = FocusNode();

  FocusNode cmpFocus = FocusNode();
  FocusNode addFocus = FocusNode();
  FocusNode phnoFocus = FocusNode();

  bool register = false;

  // void _submit() {}

  void _submitEmail(value) {
    emailController.text = value;
    passwordFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        fontFamily: 'Comfortaa');
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    TextFormField emailForm1 = TextFormField(
      // style: textStyle.copyWith(fontSize: width * 0.05),
      cursorHeight: 30, // autofocus: true,
      controller: emailController,
      key: const ValueKey('email'),
      onFieldSubmitted: _submitEmail,
      decoration: InputDecoration(
        labelText: "Enter Email",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      // TODO : enable this when production
      validator: (val) {
        if (val?.length == 0) {
          return "Email cannot be empty";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontFamily: "Poppins",
      ),
    );
    TextFormField pwdForm = TextFormField(
      style: textStyle.copyWith(fontSize: width * 0.05),
      key: const ValueKey('pwd'),
      controller: pwdController,
      focusNode: passwordFocus,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: textStyle,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: (value) {
        if (register && value! != pwdConfirmController.text) {
          setState(() {
            isPressed = false;
          });
          return "Passwords must be equal";
        }
        if (value!.length < 8) {
          setState(() {
            isPressed = false;
          });
          return "Enter a password of length greater than 8";
        }
        return null;
      },
    );
    TextFormField pwdConfirmForm = TextFormField(
      style: textStyle.copyWith(fontSize: width * 0.05),
      key: const ValueKey('pwdc'),
      controller: pwdConfirmController,
      focusNode: passwordConfirmFocus,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm your password",
        labelStyle: textStyle,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
    );
    TextFormField cmpForm = TextFormField(
      style: textStyle.copyWith(fontSize: width * 0.05),
      key: const ValueKey('cmp'),
      controller: cmpController,
      focusNode: cmpFocus,
      decoration: InputDecoration(
        labelText: "Company Name",
        labelStyle: textStyle,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            isPressed = false;
          });
          return "Enter Company name ";
        }
        return null;
      },
    );
    TextFormField addForm = TextFormField(
      style: textStyle.copyWith(fontSize: width * 0.05),
      key: const ValueKey('add'),
      controller: addController,
      focusNode: addFocus,
      decoration: InputDecoration(
        labelText: "Address",
        labelStyle: textStyle,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            isPressed = false;
          });
          return "Enter Address ";
        }
        return null;
      },
    );
    TextFormField phnoForm = TextFormField(
      keyboardType: TextInputType.number,
      style: textStyle.copyWith(fontSize: width * 0.05),
      key: const ValueKey('ph'),
      controller: phnoController,
      focusNode: phnoFocus,
      decoration: InputDecoration(
        labelText: "Phone Number",
        labelStyle: textStyle,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            isPressed = false;
          });
          return "Enter Phone Number";
        }
        return null;
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Ecotag",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 60,
                              fontFamily: 'Lobster'),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0, top: 20.0),
                                child: emailForm1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0, top: 20.0),
                                child: pwdForm,
                              ),
                              if (register)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 20.0),
                                  child: pwdConfirmForm,
                                ),
                              if (register)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 20.0),
                                  child: addForm,
                                ),
                              if (register)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 20.0),
                                  child: cmpForm,
                                ),
                              if (register)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30.0, top: 20.0),
                                  child: phnoForm,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        isPressed
                            ? const CircularProgressIndicator()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(100, 50),
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      elevation: 4,
                                      // shape: const CircleBorder(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            22), // <-- Radius
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 60,
                                          right: 60,
                                          top: 15,
                                          bottom: 15),
                                    ),
                                    child: Text(
                                      register ? "Register" : "Log in",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Comfortaa'),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        isPressed = true;
                                      });
                                      //_submit();
                                      if (_formKey.currentState!.validate()) {
                                        debugPrint(
                                            "${emailController.text} ${pwdController.text}");
                                        if (register) {
                                          await registerWithEmailPassword(
                                            emailController.text,
                                            pwdController.text,
                                            nameController.text,
                                          ).then((result) async {
                                            if (result != null) {
                                              final s = await SharedPreferences
                                                  .getInstance();
                                              s.setBool("logged_in", true);

                                              Position position =
                                                  await Geolocator
                                                      .getCurrentPosition(
                                                desiredAccuracy:
                                                    LocationAccuracy.medium,
                                              );

                                              EcoTagAPI().addManufacturer(
                                                  id: result.uid,
                                                  company: cmpController.text,
                                                  lat: position.latitude,
                                                  long: position.longitude,
                                                  address: addController.text,
                                                  phone: phnoController.text);
                                            }
                                          }).catchError((error) {
                                            debugPrint(
                                                'Registration Error: $error');
                                          });
                                        } else {
                                          if (!fillForm) {
                                            setState(() {
                                              fillForm = true;
                                            });
                                          } else {
                                            setState(() {
                                              isPressed = true;
                                            });
                                            //_submit();
                                          }
                                          if (_formKey.currentState!
                                              .validate()) {
                                            debugPrint(
                                                "${emailController.text} ${pwdController.text}");
                                            await signInWithEmailPassword(
                                                    emailController.text,
                                                    pwdController.text)
                                                .then((result) async {
                                              if (result != null) {
                                                final s =
                                                    await SharedPreferences
                                                        .getInstance();
                                                s.setBool("logged_in", true);
                                              }
                                            }).catchError((error) {
                                              showToast('Login Error: $error');
                                              setState(() {
                                                isPressed = false;
                                              });
                                            });
                                          }
                                        }
                                      }
                                    },
                                  ), //Register
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        register
                                            ? "Already a user ?"
                                            : "Dont have an account?",
                                        style: textStyle,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        child: Text(
                                          register ? "Sign-in" : "Register",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'Comfortaa'),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            register = !register;
                                          });
                                        },
                                      ) // Login
                                    ],
                                  ),
                                ],
                              )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
