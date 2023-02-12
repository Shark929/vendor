import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryId;
  late String category;

  CategoryModel({
    this.categoryId,
    required this.category,
  });

  CategoryModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    categoryId = documentSnapshot.id;
    category = documentSnapshot['category'];
  }
}
