import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:th_dkweb/Controller/home_controller.dart';
import 'package:th_dkweb/Model/fav_caetegory_item.dart';
import 'package:th_dkweb/constant.dart';

import 'details.dart';
import 'utils/cached_image.dart';

class CategoryItems extends StatefulWidget {
  String? selectedCatagory;
  CategoryItems(this.selectedCatagory);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimarColor,
      appBar: AppBar(
        title: Text(widget.selectedCatagory.toString()),
        backgroundColor: PrimarColor,
      ),
      body: Stack(
        children: <Widget>[
          GetBuilder<HomeController>(
              builder: (controller) => Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.width * 0.8,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: controller.Itemcategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                      tag: 'category$index',
                                      child: cachedImage(
                                        controller
                                            .Itemcategory[index].image_url,
                                      )),
                                  Positioned(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.04,
                                    //left: MediaQuery.of(context).size.width*0.2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          controller
                                              .Itemcategory[index].category,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: IconButton(
                                            onPressed: () {
                                              controller.addProducts(
                                                FavCategoryItem(
                                                    category: controller
                                                        .Itemcategory[index]
                                                        .category,
                                                    image_url: controller
                                                        .Itemcategory[index]
                                                        .image_url,
                                                    loves: controller
                                                        .Itemcategory[index]
                                                        .loves,
                                                    timestamp: controller
                                                        .Itemcategory[index]
                                                        .timestamp),
                                              );
                                              controller.getAllProducts();
                                            },
                                            icon: controller.FavIcon(controller
                                                        .Itemcategory[index]) ==
                                                    true
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(Icons.favorite_border,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,

                                    // bottom: MediaQuery.of(context).size.height * 0.01,
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() async {
                                                try {
                                                  //showLoadingDialog(context);
                                                  // Saved with this method.
                                                  var imageId =
                                                      await ImageDownloader
                                                          .downloadImage(
                                                              controller
                                                                  .Itemcategory[
                                                                      index]
                                                                  .image_url);
                                                  if (controller
                                                          .Itemcategory[index]
                                                          .image_url ==
                                                      null) {
                                                    return;
                                                  }
                                                  // Below is a method of obtaining saved image information.
                                                  var fileName =
                                                      await ImageDownloader
                                                          .findName(controller
                                                              .Itemcategory[
                                                                  index]
                                                              .image_url);
                                                  var path =
                                                      await ImageDownloader
                                                          .findPath(controller
                                                              .Itemcategory[
                                                                  index]
                                                              .image_url);
                                                  var size =
                                                      await ImageDownloader
                                                          .findByteSize(
                                                              controller
                                                                  .Itemcategory[
                                                                      index]
                                                                  .image_url);
                                                  var mimeType =
                                                      await ImageDownloader
                                                          .findMimeType(
                                                              controller
                                                                  .Itemcategory[
                                                                      index]
                                                                  .image_url);
                                                  Navigator.pop(context);
                                                  //Fluttertoast.showToast(
                                                  //    msg: "Image downloaded.",
                                                  //    toastLength: Toast.LENGTH_SHORT,
                                                  //    gravity: ToastGravity.CENTER,
                                                  //    timeInSecForIosWeb: 1,
                                                  //    backgroundColor: Colors.grey,
                                                  //    textColor: Colors.white,
                                                  //    fontSize: 16.0);
                                                } on PlatformException catch (error) {
                                                  print(error);
                                                }
                                                //});
                                              });
                                            },
                                            icon: Icon(
                                              Icons.download,
                                              color: Colors.blue,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.to(DetailsPage(
                                    model: controller.Itemcategory[index]));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )),
        ],
      ),
    );
  }
}
