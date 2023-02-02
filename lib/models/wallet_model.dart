import 'package:cloud_firestore/cloud_firestore.dart';

class WalletModel {
  late String? transactionId;
  late Timestamp date;
  late String amount;
  late int code;
  late String uid;

  WalletModel({
    this.transactionId,
    required this.date,
    required this.amount,
    required this.code,
    required this.uid,
  });

  WalletModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    transactionId = documentSnapshot.id;
    date = documentSnapshot['date'];
    amount = documentSnapshot['amount'];
    code = documentSnapshot['code'];
    uid = documentSnapshot['uid'];
  }
}
