import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:th_dkweb/Controller/home_controller.dart';
import 'package:th_dkweb/View/category.dart';
import 'package:th_dkweb/View/explore.dart';
import 'package:th_dkweb/View/favorite_page.dart';
import 'package:th_dkweb/View/home_view.dart';

import '../constant.dart';
import 'utils/extenstion.dart';

class RoutingScreen extends StatefulWidget {
  static final id = "RoutingScreen";

  @override
  _RoutingScreenState createState() => _RoutingScreenState();

  const RoutingScreen();
}

class _RoutingScreenState extends State<RoutingScreen> {
  int bottomSelectedIndex = 0;
  var pageController;

  void OnPageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void OnbottomTapped(int index) {
    if ((bottomSelectedIndex - index.abs() == 1)) {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      pageController.jumpToPage(index);
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final pageView = PageView(
        controller: pageController,
        children: [HomePage(), CategoryView(), ExplorePage(), FavoritePage()],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: OnPageChanged);

    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        backgroundColor: PrimarColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 5, left: 40, right: 40),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                side: BorderSide(color: HexColor.fromHex("#9263E9"), width: 1)),
            color: Colors.grey[200],
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.shifting,
              items: [
                BottomNavigationBarItem(
                    backgroundColor: PrimarColor,
                    icon: Icon(Icons.home_filled,
                        color: Colors.grey[600], size: 20),
                    title: Text(
                      'Home',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.black38, fontSize: 20),
                    )),
                BottomNavigationBarItem(
                    backgroundColor: PrimarColor,
                    icon: Icon(Icons.grid_view_outlined,
                        color: Colors.grey[600], size: 20),
                    title: Text(
                      'Categories',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.black38, fontSize: 20),
                    )),
                BottomNavigationBarItem(
                  backgroundColor: PrimarColor,
                  icon: Icon(Icons.explore, color: Colors.grey[600], size: 20),
                  title: Text(
                    'Explore',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.black38, fontSize: 20),
                  ),
                ),
                BottomNavigationBarItem(
                  backgroundColor: PrimarColor,
                  icon: Icon(Icons.favorite_border_rounded,
                      color: Colors.grey[600], size: 20),
                  title: Text(
                    'Favorite',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.black38, fontSize: 20),
                  ),
                ),
              ],
              onTap: OnbottomTapped,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              currentIndex: bottomSelectedIndex,
            ),
          ),
        ),
        body: pageView,
      ),
    );
  }
}
