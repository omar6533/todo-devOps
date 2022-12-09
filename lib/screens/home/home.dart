import 'package:cloud_firestore/cloud_firestore.dart';
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
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('ToDo')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, i) {
                                  DocumentSnapshot documentSnapshot = snapshot
                                      .data
                                      ?.docs[i] as DocumentSnapshot<Object?>;

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      // color: Colors.blue,
                                    ),
                                    margin: const EdgeInsets.all(8),
                                    child: ListTile(
                                      iconColor: Colors.green,
                                      leading: const Icon(Icons.update),
                                      title: Text(
                                        documentSnapshot['note'],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete)),
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox();
                          });
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
