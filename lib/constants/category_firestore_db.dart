import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/category_model.dart';

class CategoryFirestoreDb {
  //add function
  // static addCategory(CategoryModel categoryModel) async {
  //   await firebaseFirestore.collection('category').add({
  //     'category': categoryModel.category,
  //   });
  // }

  //get function
  static Stream<List<CategoryModel>> categoryStream() {
    return firebaseFirestore
        .collection('category')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<CategoryModel> categories = [];
      for (var category in querySnapshot.docs) {
        final categoryModel =
            CategoryModel.fromDocumentSnapshot(documentSnapshot: category);

        categories.add(categoryModel);
      }

      return categories;
    });
  }

  //update function

  //delete function
  static deleteCategory(String categoryId) {
    firebaseFirestore.collection('category').doc(categoryId).delete();
  }
}
