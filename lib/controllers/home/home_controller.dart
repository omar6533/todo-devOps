import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/services/app_snakbar.dart';

class HomeController extends GetxController {
  TextEditingController textEditingControllerNote = TextEditingController();
  SinginController _singinController = Get.find();

  addUserNote(String note) async {
    try {
      CollectionReference mycollectoin =
          await FirebaseFirestore.instance.collection('ToDo');
      mycollectoin.add({
        "note": "${note}",
        "userEmail": "${_singinController.email.text.toLowerCase()}"
      });
    } catch (e) {
      appSnackBar('Erorr', e, Colors.red);
    }
  }

  getUserNotes() {
    User? userInfo = FirebaseAuth.instance.currentUser;
    if (User == null) {
      return null;
    } else {
      return userInfo;
    }
  }

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

  bool validNote(String note) {
    if (note.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
