import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/user_wallet_model.dart';
import 'package:vendor/models/wallet_balance_model.dart';

class UserRefundFirestoreDb {
  //create
  static addWallet(UserWalletModel walletModel) async {
    await firebaseFirestore
        .collection('userWalletBalance')
        .doc(authController.user.uid)
        .set({
      'balance': walletModel.balance,
      'userId': walletModel.userId,
    });
  }

  //read
  static Stream<List<UserWalletModel>> walletStream() {
    return firebaseFirestore
        .collection('userWalletBalance')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<UserWalletModel> wallets = [];
      for (var wallet in querySnapshot.docs) {
        final walletModel = UserWalletModel.fromDocumentSnapshot(wallet);
        wallets.add(walletModel);
      }
      return wallets;
    });
  }
  //update
  //update amount

  static refundAmount(String newBalance, documentId) {
    firebaseFirestore.collection('userWalletBalance').doc(documentId).update(
      {
        'balance': newBalance,
      },
    );
  }
  //delete
}
