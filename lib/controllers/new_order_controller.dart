import 'package:get/get.dart';
import 'package:vendor/constants/customer_order_firestoredb.dart';
import 'package:vendor/models/new_order_model.dart';

class NewOrderController extends GetxController {
  Rx<List<NewOrderModel>> orderList = Rx<List<NewOrderModel>>([]);

  List<NewOrderModel> get order => orderList.value;

  @override
  void onReady() {
    orderList.bindStream(NewOrderFirestoreDb.newOrderStream());
  }
}
