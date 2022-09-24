import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final hinttext;
  final isPassword;
  final rightIcon;
  final textEditingController;
  final onChanged;
  const AppTextField({
    Key? key,
    required this.hinttext,
    this.isPassword = false,
    this.rightIcon,
    this.textEditingController,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        controller: textEditingController,
        obscureText: isPassword,
        decoration: InputDecoration(
            suffixIcon: rightIcon,
            hintText: hinttext,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))));
  }
}
