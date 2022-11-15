import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:mytodo/screens/auth/sign.dart';
import 'package:mytodo/screens/home/home.dart';
import 'package:mytodo/services/app_snakbar.dart';
import 'package:mytodo/services/loading.dart';

class SinginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isLoading = false.obs;

  isValidEmail(email) {
    bool valid = false;
    valid = GetUtils.isEmail(email.toString());

    return valid;
  }

  issUserLogedin() {
    var user = FirebaseAuth.instance.currentUser;
    // print('---------------------------------$user');
    if (user != null) {
      isLoading = true.obs;
      update();
    } else {
      isLoading = false.obs;
      update();
    }
    return isLoading;
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
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return response;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        closeLoding();
        // ignore: avoid_print
        print('No user found for that email.');
        Get.dialog(
            appSnackBar('error', 'No user found for that email', Colors.red));
      } else if (e.code == 'wrong-password') {
        closeLoding();

        // ignore: avoid_print
        print('Wrong password provided for that user.');
        Get.dialog(appSnackBar(
            'error', 'Wrong password provided for that user.', Colors.red));
      }
    }
  }

  singOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.off(SignInScreen());
    } catch (e) {
      appSnackBar('Erorr', e, Colors.red);
    }
  }
}
