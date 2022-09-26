import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/screens/auth/singup.dart';
import 'package:mytodo/screens/home/home.dart';
import 'package:mytodo/services/app_snakbar.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  GlobalKey<FormState> formState = GlobalKey<FormState>();

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
                Form(
                    key: formState,
                    child: Column(
                      children: [
                        AppTextField(
                            validator: (val) {
                              bool valid = _signinController.isValidEmail(val);
                              if (valid == false) {
                                return 'please enter a valid email';
                              }
                            },
                            onSaved: (newVal) {
                              _signinController.email = newVal;
                            },
                            // onChanged: (val) {
                            //   _signinController.isValidEmail(val);
                            // },
                            hinttext: 'Enter your email',
                            textEditingController: _signinController.email),
                        const SizedBox(height: 16),
                        AppTextField(
                          validator: (val) {
                            bool valid = _signinController.isValidPassword(val);
                            if (valid == false) {
                              return 'please enter a valid password at least 8 character';
                            }
                          },
                          onSaved: (newVal) {
                            _signinController.password = newVal;
                          },
                          // onChanged: (val) {
                          //   _signinController.isValidPassword(val);
                          // },
                          textEditingController: _signinController.password,
                          hinttext: 'Enter your password',
                          isPassword: true,
                        ),
                      ],
                    )),
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
                    onPressed: () async {
                      var current = formState.currentState;
                      if (current!.validate()) {
                        UserCredential response =
                            await _signinController.signIn(
                                _signinController.email.text,
                                _signinController.password.text);
                        print('----------------------------${response.user}');
                        if (response != null) {
                          Get.to(Home());
                        }
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
