import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signup_controller.dart';
import 'package:mytodo/screens/auth/sign.dart';
import 'package:mytodo/services/app_snakbar.dart';
import 'package:mytodo/services/loading.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();
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
                      color: Colors.green,
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
                            // onChanged: _singUpController
                            //     .isValidFullName(_singUpController.fullName.text),

                            hinttext: 'Enter your Full name',
                            textEditingController: _singUpController.fullName),
                        const SizedBox(height: 16),
                        AppTextField(
                          // onChanged: _singUpController
                          //     .isValidEmail(_singUpController.email.text),
                          validator: (val) {
                            bool valid = _singUpController.isValidEmail(val);
                            if (valid == false) {
                              return 'please enter a valid email';
                            }
                          },
                          onSaved: (val) {
                            _singUpController.email.text = val;
                          },
                          hinttext: 'Enter your email',
                          textEditingController: _singUpController.email,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          // onChanged: _singUpController
                          //     .isValidPassword(_singUpController.password.text),
                          validator: (val) {
                            bool valid = _singUpController.isValidPassword(val);
                            if (valid == false) {
                              return 'your password should not be less than 8 characters';
                            }
                          },
                          onSaved: (val) {
                            _singUpController.password.text = val;
                          },
                          textEditingController: _singUpController.password,
                          hinttext: 'Enter your password',
                          isPassword: true,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 8,
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () async {
                    var current = formState.currentState;
                    if (current!.validate()) {
                      current.save();
                      showLoading(context);
                      // var response = await _singUpController.singUp(
                      //     _singUpController.email.text,
                      //     _singUpController.password.text);
                      var response = _singUpController.singUp(
                          _singUpController.email.text,
                          _singUpController.password.text);
                      closeLoding();
                      // ignore: avoid_print
                      print(
                          '---------current response in the sign up page------$response');

                      // ignore: unnecessary_null_comparison
                      if (response != null) {
                        // ignore: avoid_print

                        appSnackBar('thank you!', 'your account was created',
                            Colors.green);
                        Get.to(SignInScreen());
                      }
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
