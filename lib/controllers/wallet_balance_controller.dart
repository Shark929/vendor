import 'package:get/get.dart';
import 'package:vendor/constants/wallet_balance_firestore_db.dart';
import 'package:vendor/models/wallet_balance_model.dart';

class WalletBalanceController extends GetxController {
  Rx<List<WalletBalanceModel>> walletBalanceList =
      Rx<List<WalletBalanceModel>>([]);
  List<WalletBalanceModel> get walletBalance => walletBalanceList.value;

  @override
  void onReady() {
    walletBalanceList
        .bindStream(WalletBalanceFirestoreDb.walletBalanceStream());
  }
}
