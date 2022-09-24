import 'package:flutter/material.dart';
import 'package:get/get.dart';

appSnackBar(title, message, color) {
  return Get.snackbar(title, message, backgroundColor: color);
}
