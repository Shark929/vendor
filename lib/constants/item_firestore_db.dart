import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/item_model.dart';

class ItemFirestoreDb {
  //create
  static addItem(ItemModel itemModel) async {
    await firebaseFirestore.collection('menus').add({
      'itemName': itemModel.itemName,
      'itemCategory': itemModel.itemCategory,
      'itemCuisineType': itemModel.itemCuisineType,
      'itemDescription': itemModel.itemDescription,
      // '': itemModel.itemId,
      'itemPicture': itemModel.itemPicture,
      'itemPrice': itemModel.itemPrice,
      'uid': itemModel.uid,
      'availabilityCode': itemModel.availabilityCode,
      'vendorId': itemModel.vendorId,
    });
  }

  //read
  static Stream<List<ItemModel>> itemStream() {
    return firebaseFirestore
        .collection('menus')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<ItemModel> items = [];
      for (var item in querySnapshot.docs) {
        final itemModel =
            ItemModel.fromDocumentSnapshot(documentSnapshot: item);
        items.add(itemModel);
      }
      return items;
    });
  }

  //update
  static updateMenuAvailable(bool isAvalable, documentId) {
    firebaseFirestore.collection('menus').doc(documentId).update(
      {
        'availabilityCode': isAvalable,
      },
    );
  }
  //delete
}
