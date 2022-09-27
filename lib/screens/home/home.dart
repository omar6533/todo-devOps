import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/controllers/home/home_controller.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.put(HomeController());
    SinginController _singInController = Get.find();
    return Scaffold(
      drawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text("Hi ${_homeController.getUserEmail().toString()}"),
            ],
          ),
        ),
      )),
      appBar: AppBar(
        title: const Text('To do'),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: IconButton(
                onPressed: () async {
                  _singInController.singOut();
                },
                icon: Icon(Icons.logout),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                hinttext: 'what are you going to do?',
                rightIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
              ),
              SingleChildScrollView()
            ],
          ),
        )),
      ),
    );
  }
}
