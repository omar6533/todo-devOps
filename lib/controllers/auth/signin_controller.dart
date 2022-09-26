import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:mytodo/screens/home/home.dart';
import 'package:mytodo/services/app_snakbar.dart';

class SinginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLogedin = false;

  isValidEmail(email) {
    bool valid = false;
    valid = GetUtils.isEmail(email.toString());

    return valid;
  }

  issUserLogedin() {
    var user = FirebaseAuth.instance.currentUser;
    // print('---------------------------------$user');
    if (user != null) {
      isLogedin = true;
      update();
    } else {
      isLogedin = false;
      update();
    }
    return isLogedin;
  }

  isValidPassword(password) {
    bool valid = false;
    if (password.isNotEmpty) {
      valid = true;
    }

    return valid;
  }

  signIn(email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        appSnackBar('error', 'No user found for that email.', Colors.red);
      } else if (e.code == 'wrong-password') {
        appSnackBar(
            'error', 'Wrong password provided for that user.', Colors.red);
      }
    }
  }
}
