import 'package:get/get.dart';
import 'package:vendor/constants/wallet_firestore_db.dart';
import 'package:vendor/models/wallet_model.dart';

class WalletController extends GetxController {
  Rx<List<WalletModel>> walletList = Rx<List<WalletModel>>([]);

  List<WalletModel> get wallet => walletList.value;

  @override
  void onReady() {
    walletList.bindStream(WalletFirestoreDb.walletStream());
  }
}
