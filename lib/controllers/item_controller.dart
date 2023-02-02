import 'package:get/get.dart';
import 'package:vendor/constants/item_firestore_db.dart';
import 'package:vendor/models/item_model.dart';

class ItemController extends GetxController {
  Rx<List<ItemModel>> itemList = Rx<List<ItemModel>>([]);

  List<ItemModel> get items => itemList.value;

  @override
  void onReady() {
    itemList.bindStream(ItemFirestoreDb.itemStream());
  }
}
