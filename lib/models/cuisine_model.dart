import 'package:cloud_firestore/cloud_firestore.dart';

class CuisineModel {
  String? cuisineId;
  late String cuisine;

  CuisineModel({
    this.cuisineId,
    required this.cuisine,
  });

  CuisineModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    cuisineId = documentSnapshot.id;
    cuisine = documentSnapshot['cuisine'];
  }
}
