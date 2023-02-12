import 'package:get/get.dart';
import 'package:vendor/constants/customer_order_firestoredb.dart';
import 'package:vendor/constants/order_firestore_db.dart';
import 'package:vendor/constants/order_history_firebasedb.dart';
import 'package:vendor/models/customer_cart_model.dart';

class OrderHistoryController extends GetxController {
  Rx<List<MyCartModel>> orderHistoryList = Rx<List<MyCartModel>>([]);

  List<MyCartModel> get orderHistory => orderHistoryList.value;

  @override
  void onReady() {
    orderHistoryList.bindStream(OrderHistoryFirestoreDb.myCartStream());
  }
}
