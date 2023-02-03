import 'package:get/get.dart';
import 'package:vendor/constants/revenue_firestore_db.dart';
import 'package:vendor/models/wallet_balance_model.dart';

class RevenueController extends GetxController {
  Rx<List<WalletBalanceModel>> revenue = Rx<List<WalletBalanceModel>>([]);
  List<WalletBalanceModel> get revenueList => revenue.value;

  @override
  void onReady() {
    revenue.bindStream(RevenueFirestoreDb.revenueStream());
  }
}
