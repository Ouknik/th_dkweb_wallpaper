import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:th_dkweb/Model/category_item_model.dart';
import 'package:th_dkweb/constant.dart';
import 'package:wallpaper/wallpaper.dart';
import 'utils/custume_button.dart';

class DetailsPage extends StatefulWidget {
  ItemCategoryModel model;
  DetailsPage({required this.model});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
  String progress = 'Set as Wallpaper or Download';

  bool downloading = false;

  late Stream<String> progressString;

  Icon downIcon = Icon(Icons.arrow_downward);
  Icon dropIcon = Icon(Icons.arrow_upward);
  Icon upIcon = Icon(Icons.arrow_upward);

  PanelController pc = PanelController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SlidingUpPanel(
      controller: pc,
      color: Colors.white.withOpacity(0.9),
      minHeight: 120,
      maxHeight: 450,
      backdropEnabled: false,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      body: Container(
        height: h,
        width: w,
        color: Colors.grey[200],
        child: Hero(
          tag: widget.model.category,
          child: CachedNetworkImage(
            imageUrl: widget.model.image_url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            placeholder: (context, url) => Icon(Icons.image),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
        ),
      ),
      panel: openParamitre(),
      onPanelClosed: () {
        setState(() {
          dropIcon = upIcon;
        });
      },
      onPanelOpened: () {
        setState(() {
          dropIcon = downIcon;
        });
      },
    ));
  }

  //widget pannel ui/ux change or dowload wallpaper
  Widget openParamitre() {
    return // floating ui
        Container(
      height: 100,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: Icon(Icons.arrow_upward),
                ),
              ),
              onTap: () {
                pc.isPanelClosed ? pc.open() : pc.close();
              },
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '#Wallpaper',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 14),
                          ),
                          Text(
                            'catagory Wallpaper',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[800],
                            child: Icon(Icons.arrow_upward),
                          ),
                        ),
                        onTap: () {
                          pc.isPanelClosed ? pc.open() : pc.close();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey[400]!,
                                    blurRadius: 10,
                                    offset: Offset(2, 2))
                              ]),
                          child: Icon(
                            Icons.format_paint,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          openSetDialog();
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Set Wallpaper',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey[400]!,
                                    blurRadius: 10,
                                    offset: Offset(2, 2))
                              ]),
                          child: Icon(
                            Icons.donut_small,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          setState(() async {
                            myInterstitial
                              ..load()
                              ..show(
                                anchorType: AnchorType.bottom,
                                anchorOffset: 0.0,
                                horizontalCenterOffset: 0.0,
                              );
                            try {
                              //showLoadingDialog(context);
                              // Saved with this method.
                              var imageId = await ImageDownloader.downloadImage(
                                  widget.model.image_url);
                              if (widget.model.image_url == null) {
                                return;
                              }
                              // Below is a method of obtaining saved image information.
                              var fileName = await ImageDownloader.findName(
                                  widget.model.image_url);
                              var path = await ImageDownloader.findPath(
                                  widget.model.image_url);
                              var size = await ImageDownloader.findByteSize(
                                  widget.model.image_url);
                              var mimeType = await ImageDownloader.findMimeType(
                                  widget.model.image_url);
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
                          //handleStoragePermission();
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Download',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 5,
                      height: 30,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        progress.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  //dialog for change wallpaper in your phone
  void openSetDialog() async {
    Get.defaultDialog(
      content: SimpleDialog(
        title: Text('SET AS'),
        contentPadding:
            EdgeInsets.only(left: 30, top: 40, bottom: 20, right: 40),
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: circularButton(Icons.format_paint, Colors.blueAccent),
            title: Text('Set As Lock Screen'),
            onTap: () async {
              myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                  horizontalCenterOffset: 0.0,
                );
              await _setLockScreen();
              Get.back();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: circularButton(Icons.donut_small, Colors.pinkAccent),
            title: Text('Set As Home Screen'),
            onTap: () async {
              myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                  horizontalCenterOffset: 0.0,
                );
              await _setHomeScreen();
              Get.back();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: circularButton(Icons.compare, Colors.orangeAccent),
            title: Text('Set As Both'),
            onTap: () async {
              myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                  horizontalCenterOffset: 0.0,
                );
              await _setBoth();
              Get.back();
            },
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  // home screen procedure
  _setHomeScreen() {
    progressString = Wallpaper.imageDownloadProgress(widget.model.image_url);
    progressString.listen((data) {
      setState(() {
        downloading = true;
        progress = 'Setting Your Home Screen\nProgress: $data';
      });

      print("DataReceived: " + data);
    }, onDone: () async {
      progress = await Wallpaper.homeScreen();
      setState(() {
        downloading = false;
        progress = progress;
      });

      openCompleteDialog();
    }, onError: (error) {
      downloading = false;

      print("Some Error");
    });
  }

  //lock screen procedure
  _setLockScreen() {
    progressString = Wallpaper.imageDownloadProgress(widget.model.image_url);
    progressString.listen((data) {
      setState(() {
        downloading = true;
        progress = 'Setting Your Lock Screen\nProgress: $data';
      });

      print("DataReceived: " + data);
    }, onDone: () async {
      progress = await Wallpaper.lockScreen();
      setState(() {
        downloading = false;
        progress = progress;
      });

      openCompleteDialog();
    }, onError: (error) {
      setState(() {
        downloading = false;
      });
      print("Some Error");
    });
  }

// both lock screen & home screen procedure
  _setBoth() {
    progressString = Wallpaper.imageDownloadProgress(widget.model.image_url);
    progressString.listen((data) {
      downloading = true;
      progress = 'Setting your Both Home & Lock Screen\nProgress: $data';

      print("DataReceived: " + data);
    }, onDone: () async {
      progress = await Wallpaper.bothScreen();

      downloading = false;
      progress = progress;

      openCompleteDialog();
    }, onError: (error) {
      downloading = false;

      print("Some Error");
    });
  }

//finish and message virifie
  void openCompleteDialog() async {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            title: 'Complete',
            animType: AnimType.SCALE,
            padding: EdgeInsets.all(30),
            body: Center(
              child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  child: Text(
                    progress,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
            ),
            btnOkText: 'Ok',
            dismissOnTouchOutside: false,
            btnOkOnPress: () {})
        .show();
  }

  handleStoragePermission() async {
    await Permission.storage.request().then((_) async {
      if (await Permission.storage.status == PermissionStatus.granted) {
        await handleDownload();
      } else if (await Permission.storage.status == PermissionStatus.denied) {
      } else if (await Permission.storage.status ==
          PermissionStatus.permanentlyDenied) {
        askOpenSettingsDialog();
      }
    });
  }

  Future handleDownload() async {
    var path = await (ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_PICTURES));
    await FlutterDownloader.enqueue(
      url: widget.model.image_url,
      savedDir: path!,
      fileName:
          'ouknik_wallpaper.th_dkweb}-${widget.model.category}${widget.model.timestamp}',
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
    setState(() {
      progress = 'Download Complete!\nCheck Your Status Bar';
    });

    await Future.delayed(Duration(seconds: 2));
    openCompleteDialog();
  }

  askOpenSettingsDialog() {
    Get.defaultDialog(
      content: AlertDialog(
        title: Text('Grant Storage Permission to Download'),
        content: Text(
            'You have to allow storage permission to download any wallpaper fro this app'),
        contentTextStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        actions: [
          TextButton(
            child: Text('Open Settins'),
            onPressed: () async {
              Get.back();
              await openAppSettings();
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () async {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
