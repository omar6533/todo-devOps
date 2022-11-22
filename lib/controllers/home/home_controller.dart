import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/services/app_snakbar.dart';

class HomeController extends GetxController {
  TextEditingController textEditingControllerNote = TextEditingController();
  late String curretUserEail;
  SinginController _singinController = Get.find();

  late RxString userEmail;
  late bool isloading;
  @override
  void initState() {
    var lengthOfuserNotes = FirebaseFirestore.instance
        .collection('ToDo')
        .where('userEmail', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .snapshots()
        .length;
  }

  addUserNote(String note, String? email) async {
    try {
      isloading = true;
      CollectionReference mycollectoin =
          await FirebaseFirestore.instance.collection('ToDo');
      mycollectoin.add({"note": "${note}", "userEmail": "${email}"});

      isloading = false;
    } catch (e) {
      Get.back();
      appSnackBar('Erorr', e, Colors.red);
    }
  }

  myCollection() async {
    var mycollectoin = await FirebaseFirestore.instance
        .collection('ToDo')
        .where('userEmail',
            isEqualTo: FirebaseAuth.instance.currentUser?.email.toString());

    return mycollectoin;
  }

  getUserNotes() async {
    var mycollectoin;
    try {
      mycollectoin = FirebaseFirestore.instance
          .collection('ToDo')
          .where('userEmail', isEqualTo: _singinController.email.text)
          .snapshots();
    } catch (e) {
      print('error when fitching data');
    }

    return mycollectoin;
  }

  getUserEmail() async {
    try {
      userEmail = (await FirebaseAuth.instance.currentUser!.email) as RxString;

      if (userEmail != null) {
        return userEmail.value;
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
