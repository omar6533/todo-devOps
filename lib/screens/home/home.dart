import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodo/controllers/auth/signin_controller.dart';
import 'package:mytodo/controllers/home/home_controller.dart';
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
      drawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [Text("hi  ${''}")],
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            currentState.save();
                            print('-------------------------');
                            print(
                                _homeController.textEditingControllerNote.text);
                            _homeController.addUserNote(
                                _homeController.textEditingControllerNote.text);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.blue,
                      ),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Icon(Icons.note),
                        title: Text('hello'),
                        trailing: IconButton(
                            onPressed: () {
                              print('object');
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
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
