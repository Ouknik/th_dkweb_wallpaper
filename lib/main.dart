// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Controller/data_bloc.dart';
import 'Controller/home_controller.dart';

import 'View/splash_scren.dart';
import 'helpear/bindings.dart';

Future<void> main() async {
  await FlutterDownloader.initialize(debug: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataBloc>(
          create: (context) => DataBloc(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
            ),
            color: Colors.white,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          textTheme: TextTheme(
              headline6: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          )),
        ),
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        home: GetBuilder<HomeController>(builder: (contrller) => SplashScren()),
      ),
    );
  }
}
