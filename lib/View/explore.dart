import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'utils/drawer.dart';
import 'utils/extenstion.dart';
import 'utils/new_items.dart';
import 'utils/popular_items.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore',
        ),
        backgroundColor: PrimarColor,
        elevation: 0.0,
      ),
      endDrawer: DrawerWidget(),
      backgroundColor: PrimarColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'New Wallpaper',
                    style: TextStyle(
                        fontSize: 20, color: HexColor.fromHex("#9263E9")),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            NewItems(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    'Popular Wallpaper',
                    style: TextStyle(
                        fontSize: 20, color: HexColor.fromHex("#9263E9")),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            PopularItems(),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
