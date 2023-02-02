import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/wallet_firestore_db.dart';
import 'package:vendor/models/wallet_model.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});
  TextEditingController amountController = TextEditingController();
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
              InkWell(
                onTap: () async {
                  final walletModel = WalletModel(
                    date: Timestamp.fromDate(DateTime.now()),
                    amount:
                        double.parse(amountController.text).toStringAsFixed(2),
                    code: 0,
                    uid: authController.user.uid,
                  );
                  await WalletFirestoreDb.addWallet(walletModel);
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
