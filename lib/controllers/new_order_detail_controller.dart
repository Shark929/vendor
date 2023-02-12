import 'package:get/get.dart';
import 'package:vendor/constants/customer_order_firestoredb.dart';
import 'package:vendor/models/customer_cart_model.dart';

class OrderItemController2 extends GetxController {
  final String orderNumber;
  OrderItemController2({
    required this.orderNumber,
  });
  Rx<List<MyCartModel>> orderList = Rx<List<MyCartModel>>([]);

  List<MyCartModel> get order => orderList.value;

  @override
  void onReady() {
    orderList.bindStream(NewOrderFirestoreDb.newOrderDetailStream(orderNumber));
  }
}
