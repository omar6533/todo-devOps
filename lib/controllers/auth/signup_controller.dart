import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:mytodo/screens/auth/sign.dart';
import 'package:mytodo/services/app_snakbar.dart';

class SignUpController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();

  isValidEmail(email) {
    bool valid = false;
    valid = GetUtils.isEmail(email);

    return valid;
  }

  isValidPassword(password) {
    bool valid = false;
    if (password.isNotEmpty) {
      valid = true;
    }

    return valid;
  }

  isValidFullName(fullName) {
    bool valid = false;
    if (fullName.isNotEmpty) {
      valid = true;
    }

    return valid;
  }

  singUp(email, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      appSnackBar('thank you!', 'your account was created', Colors.green);
      Get.to(const SignInScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        appSnackBar('error', 'The password provided is too weak.', Colors.red);
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        appSnackBar(
            'error', 'The account already exists for that email..', Colors.red);
      }
    } catch (e) {
      print(e);
    }
  }
}
