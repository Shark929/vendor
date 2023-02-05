import 'package:get/get.dart';
import 'package:vendor/constants/location_firestore_db.dart';
import 'package:vendor/models/location_model.dart';

class LocationController extends GetxController {
  Rx<List<LocationModel>> locationList = Rx<List<LocationModel>>([]);

  List<LocationModel> get location => locationList.value;

  @override
  void onReady() {
    locationList.bindStream(LocationFirestoreDb.locationStream());
  }
}
