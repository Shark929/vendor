import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/wallet_model.dart';

class WalletFirestoreDb {
  //create
  static addWallet(WalletModel walletModel) async {
    await firebaseFirestore.collection('wallets').add({
      'amount': walletModel.amount,
      'code': walletModel.code,
      'date': walletModel.date,
      'uid': authController.user.uid,
    });
  }

  //read

  static Stream<List<WalletModel>> walletStream() {
    return firebaseFirestore
        .collection('wallets')
        .orderBy('date', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<WalletModel> wallets = [];

      for (var wallet in querySnapshot.docs) {
        final walletModel =
            WalletModel.fromDocumentSnapshot(documentSnapshot: wallet);
        wallets.add(walletModel);
      }
      return wallets;
    });
  }
  //update

  //delete
}
