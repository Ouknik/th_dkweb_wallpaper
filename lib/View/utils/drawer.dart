import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:launch_review/launch_review.dart';
import 'package:th_dkweb/View/category.dart';
import 'package:th_dkweb/View/home_view.dart';

import '../explore.dart';
import 'extenstion.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var textCtrl = TextEditingController();

  final List title = ['Categories', 'Explore', 'Rate & Review'];

  final List icons = [Icons.home, Icons.grid_view, Icons.explore];

  void handleRating() {
    LaunchReview.launch(
        androidAppId: "com.aknik.th_dkweb", iOSAppId: null, writeReview: true);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: HexColor.fromHex("#F2F2FD"),
      child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: ExactAssetImage("lib/images/th_dkweb.png"),
                  fit: BoxFit.cover,
                )),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.teal,
                          backgroundImage:
                              ExactAssetImage("lib/images/logo.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: title.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Container(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                icons[index],
                                color: Colors.grey,
                                size: 22,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(title[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        if (index == 0) {
                          Get.back();
                        } else if (index == 1) {
                          Get.back();
                        } else if (index == 1) {
                          Get.back();
                        } else if (index == 2) {
                          handleRating();
                        }
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Divider(),
                      InkWell(
                        child: Container(
                          height: 45,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
