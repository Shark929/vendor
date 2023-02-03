import 'package:cloud_firestore/cloud_firestore.dart';

class WalletBalanceModel {
  String? walletBalanceId;
  // late Timestamp date;
  late String balance;
  late String vendorId;

  WalletBalanceModel({required this.balance, required this.vendorId});

  WalletBalanceModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    walletBalanceId = documentSnapshot.id;
    // date = documentSnapshot['date'];
    balance = documentSnapshot['balance'];
    vendorId = documentSnapshot['vendorId'];
  }
}
