import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  late String username;
  late int quantity;
  late String customization;
  late String uid;
  late String code;
  late String foodName;
  late String vendorId;
  late String foodPic;
  late double foodPrice;
  late String pickupTime;
  late bool isDineIn;

  OrderModel({
    this.orderId,
    required this.username,
    required this.quantity,
    required this.customization,
    required this.uid,
    required this.code,
    required this.foodName,
    required this.foodPic,
    required this.foodPrice,
    required this.vendorId,
    required this.pickupTime,
    required this.isDineIn,
  });

  OrderModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    orderId = documentSnapshot.id;
    username = documentSnapshot['username'];
    quantity = documentSnapshot['quantity'];
    customization = documentSnapshot['customization'];
    uid = documentSnapshot['uid'];
    code = documentSnapshot['code'];
    foodName = documentSnapshot['foodName'];
    foodPic = documentSnapshot['foodPic'];
    foodPrice = documentSnapshot['foodPrice'];
    vendorId = documentSnapshot['vendorId'];
    pickupTime = documentSnapshot['pickupTime'];
    isDineIn = documentSnapshot['isDineIn'];
  }
}
