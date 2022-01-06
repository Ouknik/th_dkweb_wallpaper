import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final CollectionReference _categorycollectionReference =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference _itemcategorys =
      FirebaseFirestore.instance.collection('contents');

  Future<List<QueryDocumentSnapshot>> getCategory() async {
    var value = await _categorycollectionReference.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getItemCategory() async {
    var value = await _itemcategorys.get();
    return value.docs;
  }
}
