import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/wallet_balance_model.dart';

class RevenueFirestoreDb {
  //create
  // static addRevenue() async {
  //     await firebaseFirestore.collection('revenue').
  // }
  //read
  static Stream<List<WalletBalanceModel>> revenueStream() {
    return firebaseFirestore
        .collection('revenue')
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
  static updateRevenueAmount(String newBalance, documentId) {
    firebaseFirestore.collection('revenue').doc(documentId).update(
      {
        'balance': newBalance,
      },
    );
  }
  //delete
}
