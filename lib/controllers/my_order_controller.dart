import 'package:get/get.dart';
import 'package:vendor/constants/order_firestore_db.dart';
import 'package:vendor/models/order_model.dart';

class OrderController extends GetxController {
  Rx<List<OrderModel>> carts = Rx<List<OrderModel>>([]);
  List<OrderModel> get cartList => carts.value;

  @override
  void onReady() {
    carts.bindStream(OrderFirestoreDb.orderStream());
  }
}
