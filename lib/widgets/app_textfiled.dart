import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final hinttext;
  final isPassword;
  final rightIcon;
  const AppTextField({
    Key? key,
    required this.hinttext,
    this.isPassword = false,
    this.rightIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
            suffixIcon: rightIcon,
            hintText: hinttext,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))));
  }
}
