import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/wallet_balance_firestore_db.dart';
import 'package:vendor/constants/wallet_firestore_db.dart';
import 'package:vendor/controllers/wallet_balance_controller.dart';
import 'package:vendor/models/wallet_model.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  TextEditingController amountController = TextEditingController();
  String balance = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Withdraw"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Withdraw amount",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "RM 10.00"),
              ),
              const SizedBox(
                height: 20,
              ),
              GetX<WalletBalanceController>(
                init: Get.put(WalletBalanceController()),
                builder: (WalletBalanceController wbController) {
                  for (int i = 0; i < wbController.walletBalance.length; i++) {
                    if (wbController.walletBalance[i].vendorId ==
                        authController.user.uid) {
                      balance = wbController.walletBalance[i].balance;
                    }
                  }
                  return const SizedBox();
                },
              ),
              InkWell(
                onTap: () async {
                  if (double.parse(balance) <
                      double.parse(amountController.text)) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              backgroundColor: Colors.red,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: const Center(
                                  child: Text(
                                    "Insufficient balance!",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 223, 223, 223),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  } else {
                    final walletModel = WalletModel(
                      date: Timestamp.fromDate(DateTime.now()),
                      amount: double.parse(amountController.text)
                          .toStringAsFixed(2),
                      code: 0,
                      uid: authController.user.uid,
                    );
                    double newBalance = double.parse(balance) -
                        double.parse(amountController.text);

                    WalletBalanceFirestoreDb.updateAmount(
                        newBalance.toStringAsFixed(2), authController.user.uid);
                    await WalletFirestoreDb.addWallet(walletModel);
                    Navigator.pop(context);
                  }
                  amountController.clear();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: const Text(
                    "Withdraw",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
