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

  getUserNotes() {}

  Future<String> getUserEmail() async {
    try {
      String? userEmail = await FirebaseAuth.instance.currentUser!.email;
      if (userEmail != null) {
        return userEmail;
      } else {
        return 'coud not get user Email ';
      }
    } catch (e) {
      return appSnackBar('Erorr', e, Colors.red);
    }
  }

  Future<String> getUserId() async {
    try {
      String? uid = await FirebaseAuth.instance.currentUser!.uid;
      if (uid != null) {
        return uid;
      } else {
        return 'could not get user id ';
      }
    } catch (e) {
      return appSnackBar('Erorr', e, Colors.red);
    }
  }
}
