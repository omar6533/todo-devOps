import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/screens/auth/sign.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                  'Sign up screen ',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 16,
                ),
                const AppTextField(hinttext: 'Enter your Full name'),
                const SizedBox(height: 16),
                const AppTextField(hinttext: 'Enter your email'),
                const SizedBox(height: 16),
                const AppTextField(
                  hinttext: 'Enter your password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () => Get.to(const SignInScreen()),
                  child: const Text('Sign up'),
                )
              ])),
        ),
      ),
    );
  }
}
