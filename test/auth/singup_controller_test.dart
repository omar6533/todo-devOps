// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:mytodo/controllers/auth/signup_controller.dart';
import 'package:mytodo/services/app_snakbar.dart';

class AuthSingUp extends Mock implements SignUpController {
  @override
  isValidEmail(email) {
    bool valid = false;
    valid = GetUtils.isEmail(email);

    return valid;
  }

  @override
  isValidPassword(password) {
    bool valid = false;
    if (password.isNotEmpty && password.length >= 8) {
      valid = true;
    }

    return valid;
  }

  @override
  singUp(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
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

void main() {
  AuthSingUp testSingup = AuthSingUp();
  test(
    'isValid email ',
    () {
      expect(testSingup.isValidEmail('omar@gmail.com'), true);
      expect(testSingup.isValidEmail('omar@gmail.'), false);
    },
  );
  test(
    'isValid password ',
    () {
      expect(testSingup.isValidPassword('12345678'), true);
      expect(testSingup.isValidPassword(''), false);
    },
  );
}
