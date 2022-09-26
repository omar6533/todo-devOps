import 'package:firebase_auth/firebase_auth.dart';
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
                GetBuilder<SinginController>(
                  builder: (controller) => MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      if (_signinController
                              .isValidEmail(_signinController.email.text) &&
                          _signinController.isValidPassword(
                              _signinController.password.text)) {
                        //calling sign in controller
                        _signinController.signIn(_signinController.email.text,
                            _signinController.password.text);
                        //if the user is loged in go to home screen
                        if (_signinController.issUserLogedin()) {
                          print(
                              '-------------------------------------------${_signinController.isLogedin}');
                          Get.to(Home());
                        }
                      } else {
                        var user = FirebaseAuth.instance.currentUser;
                        print(
                            '-------------------------------------------${_signinController.issUserLogedin()}');
                        // print('---------------------------------$user');

                        appSnackBar(
                            'wrong email or password',
                            'please enter a valid email or a valid password',
                            Colors.yellow);
                      }
                    },
                    child: const Text('Sign in'),
                  ),
                )
              ])),
        ),
      ),
    );
  }
}
