import 'package:flutter/cupertino.dart';

class FavCategoryItem {
  late String category;
  late String image_url;
  late String loves;
  late String timestamp;
  FavCategoryItem(
      {required this.category,
      required this.image_url,
      required this.loves,
      required this.timestamp});
  FavCategoryItem.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    category = map['category'];
    image_url = map['image_url'];
    loves = map['loves'].toString();
    timestamp = map['timestamp'].toString();
  }
  toJson() {
    return {
      'category': category,
      'image_url': image_url,
      'loves': loves,
      'timestamp': timestamp,
    };
  }
}
