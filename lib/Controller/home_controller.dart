import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:th_dkweb/Model/category_item_model.dart';
import 'package:th_dkweb/Model/category_model.dart';
import 'package:th_dkweb/Model/fav_caetegory_item.dart';
import 'database/cord_database_holder.dart';
import 'servire/home_servire.dart';

class HomeController extends GetxController {
  HomeController() {
    getCategory();
    _getCategoryItem();
    getAllProducts();
    getNewItem();
  }
  final CollectionReference _categorycollectionReference =
      FirebaseFirestore.instance.collection('categories');
  String progress = 'Set as Wallpaper or Download';
  ValueNotifier<bool> get loding => _loding;
  ValueNotifier<bool> _loding = ValueNotifier(false);
  List<CategoryModel> get categoryModel => _categoryModel;
  late List<CategoryModel> _categoryModel = [];
  List<ItemCategoryModel> get Itemcategory => _getItemcategory;
  late List<ItemCategoryModel> _getItemcategory = [];
  List<String> get SLiderItemcategory => _SliderImage;
  List<String> _SliderImage = [];
  late List<ItemCategoryModel> _Itemcategory = [];

  removeList(list) {
    if (list != 0) {
      for (int i = 0; i < list.length; i++) {
        list.removeAt(i);
      }
    } else {}
    if (list != 0) {
      for (int i = 0; i < list.length; i++) {
        list.removeAt(i);
      }
    } else {}
  }

  getCategoryItem(category) {
    removeList(_getItemcategory);
    removeList(_getItemcategory);
    removeList(_getItemcategory);

    for (int i = 0; i < _Itemcategory.length; i++) {
      if (_Itemcategory[i].category == category) {
        _getItemcategory.add(_Itemcategory[i]);
      }
    }
  }

  _getCategoryItem() {
    HomeService().getItemCategory().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              _Itemcategory.add(ItemCategoryModel.fromJson(
                  value[i].data() as Map<String, dynamic>)),
              _SliderImage.add(_Itemcategory[i].image_url),
            }
        });

    update();
  }

  getCategory() async {
    _loding.value = true;

    _categorycollectionReference.get().then((value) => {
          for (int i = 0; i < value.docs.length; i++)
            {
              _categoryModel.add(CategoryModel.fromJson(
                  value.docs[i].data() as Map<String, dynamic>)),
              _SliderImage.add(_categoryModel[i].image),
              _loding.value = false
            }
        });
    update();
  }

//get just new item
  List<ItemCategoryModel> get NewItem => _newitem;
  List<ItemCategoryModel> _newitem = [];
  getNewItem() {
    if (!_Itemcategory.isEmpty)
      for (int i = 0; i < 10; i++) {
        _newitem.add(_Itemcategory[i]);
      }
  }

////favorite add / delete
  var dbHalper = CordDatabaseHelper.db;
  bool get loading => _loading;
  bool _loading = false;

  List<FavCategoryItem> _cartProductsModel = [];
  List<FavCategoryItem> get cartProductsModel => _cartProductsModel;

  double _totlaprice = 0;
  bool verife = false;

  getAllProducts() async {
    _loading = true;
    var dbHelper = CordDatabaseHelper.db;

    _cartProductsModel =
        (await dbHelper.getAllProdects()).cast<FavCategoryItem>();

    update();
  }

  addProducts(FavCategoryItem cartProductsModel) async {
    for (int i = 0; i < _cartProductsModel.length; i++) {
      if (_cartProductsModel[i].category == cartProductsModel.category &&
          _cartProductsModel[i].image_url == cartProductsModel.image_url &&
          _cartProductsModel[i].timestamp == cartProductsModel.timestamp) {
        removeFAv(FavCategoryItem(
            category: cartProductsModel.category,
            image_url: cartProductsModel.image_url,
            loves: cartProductsModel.loves,
            timestamp: cartProductsModel.timestamp));
        return;
      }
    }

    await dbHalper.inser(cartProductsModel);

    update();
  }

  removeFAv(FavCategoryItem model) async {
    await dbHalper.removeProducs(model);
    getAllProducts();
    update();
  }

  FavIcon(ItemCategoryModel mode) {
    for (int i = 0; i < _cartProductsModel.length; i++) {
      if (mode.category == _cartProductsModel[i].category &&
          mode.image_url == _cartProductsModel[i].image_url &&
          mode.timestamp == _cartProductsModel[i].timestamp) {
        return true;
      }
    }

    return false;
  }

  //admobe
  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: "ca-app-pub-4738727897181009/7651537033",
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );
}
