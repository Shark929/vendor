import 'package:cloud_firestore/cloud_firestore.dart';

class UserWalletModel {
  String? walletBalanceId;
  // late Timestamp date;
  late String balance;
  late String userId;

  UserWalletModel({required this.balance, required this.userId});

  UserWalletModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    walletBalanceId = documentSnapshot.id;
    // date = documentSnapshot['date'];
    balance = documentSnapshot['balance'];
    userId = documentSnapshot['userId'];
  }
}
