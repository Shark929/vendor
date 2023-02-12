import 'package:get/get.dart';
import 'package:vendor/constants/cuisine_firestore_db.dart';
import 'package:vendor/models/cuisine_model.dart';

class CuisineController extends GetxController {
  Rx<List<CuisineModel>> cuisineList = Rx<List<CuisineModel>>([]);

  List<CuisineModel> get cuisine => cuisineList.value;

  @override
  void onReady() {
    cuisineList.bindStream(CuisineFirestoreDb.cuisineStream());
  }
}
