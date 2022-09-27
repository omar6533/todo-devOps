import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mytodo/services/app_snakbar.dart';

class HomeController extends GetxController {
  getUser() async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      appSnackBar('Erorr', e, Colors.red);
    }
  }

  Future<String> getUserEmail() async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.email.toString();
      } else {
        return '';
      }
    } catch (e) {
      return appSnackBar('Erorr', e, Colors.red);
    }
  }
}
