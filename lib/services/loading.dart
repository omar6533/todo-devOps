import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: 200,
            height: 200,
            child: const AlertDialog(
              content: CircularProgressIndicator(),
            ),
          ),
        );
      });
}

closeLoding() {
  Get.back();
}
