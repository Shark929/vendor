import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/controllers/wallet_balance_controller.dart';
import 'package:vendor/controllers/wallet_controller.dart';
import 'package:vendor/screens/withdraw_screen.dart';
import 'package:timeago/timeago.dart' as tago;

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("My Wallet"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => WithdrawScreen());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Foodie Wallet",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Balance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GetX<WalletBalanceController>(
                            init: Get.put(WalletBalanceController()),
                            builder: (WalletBalanceController
                                walletBalanceController) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: walletBalanceController
                                      .walletBalance.length,
                                  itemBuilder: (context, index) {
                                    final walletBalanceModel0 =
                                        walletBalanceController
                                            .walletBalance[index];

                                    if (walletBalanceModel0.vendorId ==
                                        authController.user.uid) {
                                      return Text(
                                        "RM ${double.parse(walletBalanceModel0.balance).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                  });
                            }),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text("Press the card to withdraw"),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetX<WalletController>(
                  init: Get.put(WalletController()),
                  builder: (WalletController walletController) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: walletController.wallet.length,
                        itemBuilder: (context, index) {
                          final walletModel0 = walletController.wallet[index];

                          if (walletModel0.uid == authController.user.uid) {
                            return ListTile(
                              title: Text(
                                walletModel0.code == 0
                                    ? "Pending"
                                    : "Successfully withdrew",
                              ),
                              subtitle: Text(tago.format(DateTime.parse(
                                  walletModel0.date.toDate().toString()))),
                              trailing: Text(
                                "RM ${walletModel0.amount}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
