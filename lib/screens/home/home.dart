import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              AppTextField(
                hinttext: 'what are you going to do?',
                rightIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
