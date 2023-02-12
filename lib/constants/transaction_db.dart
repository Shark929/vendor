import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/transaction_model.dart';

class TransactionFirestoreDb {
  //create
  static addTransaction(TransactionModel transactionModel) async {
    await firebaseFirestore.collection('customerTransactions').add({
      'amount': transactionModel.amount,
      'code': transactionModel.code,
      'date': transactionModel.date,
      'uid': transactionModel.uid,
    });
  }

  //read

  //update

  //delete
}
