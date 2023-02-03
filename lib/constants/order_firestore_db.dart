import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/order_model.dart';

class OrderFirestoreDb {
  //create
  // static addToVendorCart(OrderModel cartModel2) async {
  //   await firebaseFirestore.collection('vendorCart').add({
  //     'code': cartModel2.code,
  //     'customization': cartModel2.customization,
  //     'foodName': cartModel2.foodName,
  //     'foodPic': cartModel2.foodPic,
  //     'foodPrice': cartModel2.foodPrice,
  //     'quantity': cartModel2.quantity,
  //     'uid': cartModel2.uid,
  //     'username': cartModel2.username,
  //     'vendorId': cartModel2.vendorId,
  //     'pickupTime': cartModel2.pickupTime,
  //     'isDineIn': cartModel2.isDineIn,
  //   });
  // }

  //read
  static Stream<List<OrderModel>> orderStream() {
    return firebaseFirestore
        .collection('vendorCart')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<OrderModel> carts = [];

      for (var cart in querySnapshot.docs) {
        final cartModel =
            OrderModel.fromDocumentSnapshot(documentSnapshot: cart);
        carts.add(cartModel);
      }

      return carts;
    });
  }

  //update
  static updateCode(String code, documentId) {
    firebaseFirestore.collection('vendorCart').doc(documentId).update(
      {
        'code': code,
      },
    );
  }
  //delete
}
