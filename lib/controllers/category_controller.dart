import 'package:get/get.dart';
import 'package:vendor/constants/category_firestore_db.dart';
import 'package:vendor/models/category_model.dart';

class CategoryController extends GetxController {
  Rx<List<CategoryModel>> categoryList = Rx<List<CategoryModel>>([]);

  List<CategoryModel> get category => categoryList.value;

  @override
  void onReady() {
    categoryList.bindStream(CategoryFirestoreDb.categoryStream());
  }
}
