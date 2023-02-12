import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/models/customer_cart_model.dart';
import 'package:vendor/models/new_order_model.dart';

import 'constants.dart';

class NewOrderFirestoreDb {
  static Stream<List<NewOrderModel>> newOrderStream() {
    return firebaseFirestore
        .collection('order')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<NewOrderModel> orders = [];
      for (var order in querySnapshot.docs) {
        final orderModel = NewOrderModel.fromDocumentSnapshot(order);

        orders.add(orderModel);
      }
      return orders;
    });
  }

  static Stream<List<MyCartModel>> newOrderDetailStream(String orderNumber) {
    return firebaseFirestore
        .collection('order')
        .doc(orderNumber)
        .collection('orderList')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<MyCartModel> orders = [];
      for (var order in querySnapshot.docs) {
        final orderModel = MyCartModel.fromDocumentSnapshot(order);
        orders.add(orderModel);
      }
      return orders;
    });
  }

  static updateCode(String orderNumber, String code) {
    firebaseFirestore.collection('order').doc(orderNumber).update({
      'code': code,
    });
  }

  static deleteOrder(String orderNumber) {
    firebaseFirestore.collection('order').doc(orderNumber).delete();
  }

  static deleteOrderList(String orderNumber, String docId) {
    firebaseFirestore
        .collection('order')
        .doc(orderNumber)
        .collection('orderList')
        .doc(docId)
        .delete();
  }
}
