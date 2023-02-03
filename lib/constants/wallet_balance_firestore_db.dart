import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/wallet_balance_model.dart';

class WalletBalanceFirestoreDb {
  //create

  //read
  static Stream<List<WalletBalanceModel>> walletBalanceStream() {
    return firebaseFirestore
        .collection('walletBalance')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<WalletBalanceModel> wallets = [];
      for (var wallet in querySnapshot.docs) {
        final walletBalanceModel =
            WalletBalanceModel.fromDocumentSnapshot(wallet);
        wallets.add(walletBalanceModel);
      }
      return wallets;
    });
  }
  //update
  //update amount

  static updateAmount(String newBalance, documentId) {
    firebaseFirestore.collection('walletBalance').doc(documentId).update(
      {
        'balance': newBalance,
      },
    );
  }
  //delete
}
