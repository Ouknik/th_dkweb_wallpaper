import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:th_dkweb/Controller/home_controller.dart';
import 'package:th_dkweb/constant.dart';

import 'catagory_items.dart';
import 'utils/drawer.dart';
import 'utils/extenstion.dart';
import 'utils/loading_widget.dart';

class CategoryView extends StatefulWidget {
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  //******intersitial admob */

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: InterstitialAdtestAdUnitId,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  ///*********end intersitial
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: PrimarColor,
      appBar: AppBar(
        backgroundColor: PrimarColor,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'Categories',
        ),
      ),
      endDrawer: DrawerWidget(),
      body: GetBuilder<HomeController>(
        builder: (controller) => GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          itemCount: controller.categoryModel.length,
          // itemBuilder: (BuildContext context, int index) {
          //   return SizedBox(
          //     height: 10,
          //   );
          // },

          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 202,
              mainAxisExtent: MediaQuery.of(context).size.width * 0.46,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),

          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                  child: Container(
                    height: 140,
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                controller.categoryModel[index].image),
                            fit: BoxFit.cover)),
                  ),
                  onTap: () {
                    myInterstitial
                      ..load()
                      ..show(
                        anchorType: AnchorType.bottom,
                        anchorOffset: 0.0,
                        horizontalCenterOffset: 0.0,
                      );
                    controller.getCategoryItem(
                        controller.categoryModel[index].nameCategory);
                    Get.to(CategoryItems(
                        controller.categoryModel[index].nameCategory));
                  },
                ),
                Container(
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#9263E9"),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: w,
                    child: Center(
                        child: Text(
                            controller.categoryModel[index].nameCategory,
                            style: TextStyle(
                                color: HexColor.fromHex("#F2F2FD"),
                                fontSize: 22,
                                fontWeight: FontWeight.w600)))),
              ],
            );
          },
        ),
      ),
    );
  }
}
