import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signup_controller.dart';
import 'package:mytodo/screens/auth/sign.dart';
import 'package:mytodo/services/app_snakbar.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController _singUpController = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Text(
                  'Sign up screen ',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                    // onChanged: _singUpController
                    //     .isValidFullName(_singUpController.fullName.text),
                    hinttext: 'Enter your Full name',
                    textEditingController: _singUpController.fullName),
                const SizedBox(height: 16),
                AppTextField(
                  // onChanged: _singUpController
                  //     .isValidEmail(_singUpController.email.text),
                  hinttext: 'Enter your email',
                  textEditingController: _singUpController.email,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  // onChanged: _singUpController
                  //     .isValidPassword(_singUpController.password.text),
                  textEditingController: _singUpController.password,
                  hinttext: 'Enter your password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    if (_singUpController
                            .isValidEmail(_singUpController.email.text) &&
                        _singUpController
                            .isValidPassword(_singUpController.password.text) &&
                        _singUpController
                            .isValidFullName(_singUpController.fullName.text)) {
                      //if there is no error will call sign up controller and go the sing in screen
                      var message = _singUpController.singUp(
                          _singUpController.email.text,
                          _singUpController.password.text);
                    } else {
                      appSnackBar(
                          'wrong email or password or full name',
                          'please enter a valid email or a valid password or full name',
                          Colors.red);
                    }
                  },
                  child: const Text('Sign up'),
                )
              ])),
        ),
      ),
    );
  }
}
