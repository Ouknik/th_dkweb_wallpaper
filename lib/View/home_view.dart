import 'dart:isolate';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:th_dkweb/Controller/data_bloc.dart';
import 'package:th_dkweb/Controller/home_controller.dart';

import '../constant.dart';
import 'catagory_items.dart';
import 'details.dart';
import 'utils/drawer.dart';
import 'utils/extenstion.dart';
import 'utils/loading_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//admob  Bannire ...........................start
  late BannerAd myBanner;
  BannerAd buildBannerAd() {
    return BannerAd(
        adUnitId: adUnitIdBannir,
        size: AdSize.smartBanner,
        listener: (MobileAdEvent event) {
          myBanner..show(anchorType: AnchorType.bottom, anchorOffset: 70);
        });
  }

  /// ************ admob bannire end
  ///// native Ads*************************** start
  final _controller = NativeAdmobController();
  Widget createNateveAds(w, h) {
    NativeAdmob nativeAdmob = NativeAdmob(
      adUnitID: adUnitIDNativ,
      controller: _controller,
    );
    return Container(
      width: w,
      height: h,
      child: nativeAdmob,
    );
  }
//native ads *********** end****************
//******intersitial admob */

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: InterstitialAdtestAdUnitId,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  ///*********end intersitial

  int listIndex = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    ///admob show
    FirebaseAdMob.instance.initialize(appId: appId);
    myBanner = buildBannerAd()..load();

    ///end admob show
    ///
    getData();
  }

  Future getData() async {
    Future.delayed(Duration(milliseconds: 0)).then((f) {
      final db = context.read<DataBloc>();

      db.getData();
      db.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DataBloc>();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallpaper",
          style: TextStyle(
              fontSize: 27, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        elevation: 0,
        backgroundColor: PrimarColor,
      ),
      key: _scaffoldKey,
      backgroundColor: PrimarColor,
      endDrawer: DrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        initialPage: 0,
                        viewportFraction: 0.90,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        height: h * 0.70,
                        onPageChanged: (int index, reason) {
                          setState(() => listIndex = index);
                        }),
                    items: db.alldata.length == 0
                        ? [0, 1].take(1).map((f) => LoadingWidget()).toList()
                        : db.alldata.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 0),
                                    child: InkWell(
                                      child: CachedNetworkImage(
                                        imageUrl: i['image_url'],
                                        imageBuilder:
                                            (context, imageProvider) => Hero(
                                          tag: i['timestamp'],
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 50),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.grey[300]!,
                                                      blurRadius: 30,
                                                      offset: Offset(5, 20))
                                                ],
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, bottom: 40),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "#Wallpaper",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14),
                                                        ),
                                                        Text(
                                                          i['category'],
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25),
                                                        )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.favorite,
                                                      size: 25,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Text(
                                                      i['loves'].toString(),
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            LoadingWidget(),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error,
                                          size: 40,
                                        ),
                                      ),
                                      onTap: () {
                                        myInterstitial
                                          ..load()
                                          ..show(
                                            anchorType: AnchorType.bottom,
                                            anchorOffset: 0.0,
                                            horizontalCenterOffset: 0.0,
                                          );
                                        //Get.to(Deta)
                                      },
                                    ));
                              },
                            );
                          }).toList(),
                  ),
                  Positioned(
                    bottom: 5,
                    left: w * 0.34,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: DotsIndicator(
                        dotsCount: 5,
                        position: listIndex.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: Colors.black,
                          color: Colors.black,
                          spacing: EdgeInsets.all(3),
                          size: const Size.square(8.0),
                          activeSize: const Size(40.0, 6.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              GetBuilder<HomeController>(
                builder: (controller) => SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.categoryModel.length,
                      itemBuilder: (context, i) {
                        return controller.categoryModel.length == 0
                            ? LoadingWidget1()
                            : Column(
                                children: [
                                  InkWell(
                                    child: Container(
                                      height: 140,
                                      width: w,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  controller
                                                      .categoryModel[i].image),
                                              fit: BoxFit.cover)),
                                      child: Align(
                                        child: Text(
                                            controller
                                                .categoryModel[i].nameCategory,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ),
                                    onTap: () {
                                      controller.getCategoryItem(controller
                                          .categoryModel[i].nameCategory);
                                      Get.to(CategoryItems(controller
                                          .categoryModel[i].nameCategory));
                                      myInterstitial
                                        ..load()
                                        ..show(
                                          anchorType: AnchorType.bottom,
                                          anchorOffset: 0.0,
                                          horizontalCenterOffset: 0.0,
                                        );
                                    },
                                  ),
                                  Container(
                                    height: 5,
                                  )
                                ],
                              );
                      }),
                ),
              ),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
