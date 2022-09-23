import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/screens/auth/singup.dart';
import 'package:mytodo/screens/home/home.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const AppTextField(hinttext: 'Enter your email'),
                const SizedBox(height: 16),
                const AppTextField(
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
                    Get.to(const Home());
                  },
                  child: const Text('Sign in'),
                )
              ])),
        ),
      ),
    );
  }
}
