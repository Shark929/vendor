import 'package:get/get.dart';
import 'package:vendor/constants/user_refund_firestore.dart';
import 'package:vendor/models/user_wallet_model.dart';

class UserRefundController extends GetxController {
  Rx<List<UserWalletModel>> walletBalanceList = Rx<List<UserWalletModel>>([]);
  List<UserWalletModel> get walletBalance => walletBalanceList.value;

  @override
  void onReady() {
    walletBalanceList.bindStream(UserRefundFirestoreDb.walletStream());
  }
}
