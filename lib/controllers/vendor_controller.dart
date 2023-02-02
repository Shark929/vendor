import 'package:get/get.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';
import 'package:vendor/models/vendor2_model.dart';

class Vendor2Controller extends GetxController {
  Rx<List<Vendor2Model>> vendorList = Rx<List<Vendor2Model>>([]);

  List<Vendor2Model> get vendor => vendorList.value;

  @override
  void onReady() {
    vendorList.bindStream(Vendor2FirestoreDb.vendor2Stream());
  }
}
