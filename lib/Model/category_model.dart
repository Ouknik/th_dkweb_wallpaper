import 'package:flutter/cupertino.dart';

class CategoryModel {
  late String nameCategory;
  late String image;
  late String temId;
  CategoryModel(
      {required this.nameCategory, required this.image, required this.temId});
  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    nameCategory = map['name'];
    image = map['thumbnail'];
    temId = map['timestamp'];
  }
  toJson() {
    return {
      'name': nameCategory,
      'thumbnail': image,
      'timestamp': temId,
    };
  }
}
