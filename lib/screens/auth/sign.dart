import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/screens/auth/singup.dart';
import 'package:mytodo/screens/home/home.dart';
import 'package:mytodo/services/app_snakbar.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SinginController _signinController = Get.put(SinginController());
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
                  'Sign in ',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                    hinttext: 'Enter your email',
                    textEditingController: _signinController.email),
                const SizedBox(height: 16),
                AppTextField(
                  textEditingController: _signinController.password,
                  hinttext: 'Enter your password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text(
                      "don't have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(const SignUpScreen());
                        },
                        child: const Text('click here'))
                  ],
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    if (_signinController
                            .isValidEmail(_signinController.email.text) &&
                        _signinController
                            .isValidPassword(_signinController.password.text)) {
                      _signinController.signIn(_signinController.email.text,
                          _signinController.password.text);
                    } else {
                      appSnackBar(
                          'wrong email or password',
                          'please enter a valid email or a valid password',
                          Colors.red);
                    }
                  },
                  child: const Text('Sign in'),
                )
              ])),
        ),
      ),
    );
  }
}
