import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:th_dkweb/Controller/home_controller.dart';
import 'package:th_dkweb/Model/fav_caetegory_item.dart';
import 'package:th_dkweb/View/details.dart';
import 'package:th_dkweb/View/utils/cached_image.dart';
import 'package:th_dkweb/View/utils/details_secondire.dart';
import 'package:th_dkweb/constant.dart';
import 'utils/extenstion.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor.fromHex("#F2F2FD"), //F2F2FD,
        body: GetBuilder<HomeController>(
            builder: (controller) => controller.cartProductsModel.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          child: Image.asset('lib/images/favorite.gif'),
                        ),
                      ),
                      Text(
                        'Favorites is empty',
                        style: (TextStyle(
                            color: HexColor.fromHex("#9263E9"), fontSize: 20)),
                      )
                    ],
                  )
                : GridView.builder(
                    itemCount: controller.cartProductsModel.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: MediaQuery.of(context).size.width * 0.8,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (context, i) {
                      return InkWell(
                        child: Stack(
                          children: <Widget>[
                            Hero(
                                tag: 'bookmark$i',
                                child: cachedImage(controller
                                    .cartProductsModel[i].image_url
                                    .toString())),
                            Positioned(
                              bottom: 30,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "#wallpaper",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Text(
                                    controller.cartProductsModel[i].category,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 20,
                              child: IconButton(
                                onPressed: () {
                                  controller.removeFAv(FavCategoryItem(
                                      category: controller
                                          .cartProductsModel[i].category,
                                      image_url: controller
                                          .cartProductsModel[i].image_url,
                                      loves:
                                          controller.cartProductsModel[i].loves,
                                      timestamp: controller
                                          .cartProductsModel[i].timestamp));
                                },
                                icon: Icon(Icons.favorite),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.to(DetileSecondPage(
                            tag: "Walppaper",
                            catagory: controller.cartProductsModel[i].category,
                            imageUrl: controller.cartProductsModel[i].image_url,
                            timestamp:
                                controller.cartProductsModel[i].timestamp,
                          ));
                        },
                      );
                    })

            /* ListView.builder(
                    itemCount: controller.cartProductsModel.length,
                    itemBuilder: (context, i) {
                      return Card(
                        color: PrimarColor,
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              cachedImage(
                                controller.cartProductsModel[i].image_url
                                    .toString(),
                              ),
                              Column(
                                children: [
                                  Text(
                                    controller.cartProductsModel[i].category
                                        .toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  const Text(
                                    "#Wallpaper",
                                    style: TextStyle(color: Colors.black26),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.removeFAv(FavCategoryItem(
                                          category: controller
                                              .cartProductsModel[i].category,
                                          image_url: controller
                                              .cartProductsModel[i].image_url,
                                          loves: controller
                                              .cartProductsModel[i].loves,
                                          timestamp: controller
                                              .cartProductsModel[i].timestamp));
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.black38,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    )*/
            ));
  }
}
