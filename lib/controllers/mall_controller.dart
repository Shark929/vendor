import 'package:get/get.dart';
import 'package:vendor/constants/mall_firestore_db.dart';
import '../models/mall_model.dart';

class MallController extends GetxController {
  Rx<List<MallModel>> mallList = Rx<List<MallModel>>([]);

  List<MallModel> get mall => mallList.value;

  @override
  void onReady() {
    mallList.bindStream(MallFirestoreDb.mallStream());
  }
}
