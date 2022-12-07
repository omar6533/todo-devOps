import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/controllers/home/home_controller.dart';
import 'package:mytodo/services/loading.dart';
import 'package:mytodo/widgets/app_textfiled.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formeState = GlobalKey<FormState>();
    HomeController _homeController = Get.put(HomeController());
    SinginController _singInController = Get.find();

    return Scaffold(
      // drawer: Drawer(
      //     child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 50),
      //     child: Column(
      //       children: [Text("hi  ${''}")],
      //     ),
      //   ),
      // )),

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
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // GetX<HomeController>(
                      //   builder: (controller) {
                      //     return Text(
                      //       '${_homeController.getUserEmail()}',
                      //       style: const TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 14,
                      //       ),
                      //     );
                      //   },
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: formeState,
                    child: AppTextField(
                      textEditingController:
                          _homeController.textEditingControllerNote,
                      validator: (val) {
                        bool isvalid = _homeController.validNote(val);
                        if (isvalid == false) {
                          return " note can't be empty";
                        }
                      },
                      onSaved: (val) {
                        _homeController.textEditingControllerNote.text = val;
                      },
                      hinttext: 'what are you going to do?',
                      rightIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          var currentState = formeState.currentState;
                          if (currentState!.validate()) {
                            print('1111111111111111111');
                            // while (_homeController.isloading == true) {
                            //   const CircularProgressIndicator();
                            // }
                            await _homeController.addUserNote(
                                _homeController.textEditingControllerNote.text,
                                FirebaseAuth.instance.currentUser?.email
                                    .toString());
                            print('22222222222222222');
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  GetBuilder<HomeController>(
                    builder: (controller) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            // color: Colors.blue,
                          ),
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            iconColor: Colors.green,
                            leading: Icon(Icons.update),
                            title: Text(
                              'new note',
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  print('object');
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

Future<String> getUserEmail() async {
  HomeController _homeController = Get.find();

  String email = await _homeController.getUserEmail().then((value) {
    return value;
  });

  print(email);

  return email.toString();
}
