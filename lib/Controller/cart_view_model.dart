import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:th_dkweb/Model/category_item_model.dart';
import 'package:th_dkweb/Model/fav_caetegory_item.dart';

import 'database/cord_database_holder.dart';

class CartViewModel extends GetxController {
  var dbHalper = CordDatabaseHelper.db;
  bool get loading => _loading;
  bool _loading = false;

  List<FavCategoryItem> _cartProductsModel = [];
  List<FavCategoryItem> get cartProductsModel => _cartProductsModel;
  double get totlaprice => _totlaprice;
  double _totlaprice = 0;
  bool verife = false;
  CartViewModel() {
    getAllProducts();
  }

  getAllProducts() async {
    _loading = true;
    var dbHelper = CordDatabaseHelper.db;

    _cartProductsModel =
        (await dbHelper.getAllProdects()).cast<FavCategoryItem>();

    update();
  }

  addProducts(FavCategoryItem cartProductsModel) async {
    for (int i = 0; i < _cartProductsModel.length; i++) {
      if (_cartProductsModel[i].image_url == cartProductsModel.image_url) {
        return;
      }
    }

    await dbHalper.inser(cartProductsModel);

    update();
  }
}
