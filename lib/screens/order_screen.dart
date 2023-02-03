import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/order_firestore_db.dart';
import 'package:vendor/constants/wallet_balance_firestore_db.dart';
import 'package:vendor/controllers/my_order_controller.dart';
import 'package:vendor/controllers/wallet_balance_controller.dart';
import 'package:vendor/screens/wallet_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var acceptList = [];
  String balance = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("My Orders"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
              GetX<OrderController>(
                  init: Get.put(OrderController()),
                  builder: (OrderController orderController) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderController.cartList.length,
                      itemBuilder: (context, index) {
                        if (acceptList.isEmpty ||
                            acceptList.length <
                                orderController.cartList.length) {
                          acceptList.add("0");
                        }
                        final orderModel0 = orderController.cartList[index];
                        return ListTile(
                          tileColor: orderModel0.code == "1"
                              ? Colors.white
                              : orderModel0.code == "2"
                                  ? Colors.green
                                  : orderModel0.code == "3"
                                      ? Colors.blue
                                      : orderModel0.code == "4"
                                          ? Colors.amber
                                          : Colors.red,
                          onTap: () {
                            if (orderModel0.code == "1" ||
                                orderModel0.code == "2" ||
                                orderModel0.code == "3") {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text(
                                            'Accept or reject order #${orderModel0.username}'),
                                        content: Row(children: [
                                          orderModel0.code == "1"
                                              ? InkWell(
                                                  onTap: () {
                                                    OrderFirestoreDb.updateCode(
                                                        '2',
                                                        orderModel0.orderId);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: const Text("Accept"),
                                                  ),
                                                )
                                              : orderModel0.code == "2"
                                                  ? InkWell(
                                                      onTap: () {
                                                        OrderFirestoreDb
                                                            .updateCode(
                                                                '3',
                                                                orderModel0
                                                                    .orderId);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                            "In Progress"),
                                                      ),
                                                    )
                                                  : orderModel0.code == "3"
                                                      ? InkWell(
                                                          onTap: () {
                                                            OrderFirestoreDb
                                                                .updateCode(
                                                                    '4',
                                                                    orderModel0
                                                                        .orderId);

                                                            double newBalance = double
                                                                    .parse(
                                                                        balance) +
                                                                (orderModel0
                                                                        .foodPrice *
                                                                    orderModel0
                                                                        .quantity);

                                                            WalletBalanceFirestoreDb
                                                                .updateAmount(
                                                                    newBalance
                                                                        .toStringAsFixed(
                                                                            2),
                                                                    authController
                                                                        .user
                                                                        .uid);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.amber,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Text(
                                                                "Completed"),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                          const Spacer(),
                                          orderModel0.code == "1"
                                              ? InkWell(
                                                  onTap: () {
                                                    OrderFirestoreDb.updateCode(
                                                        '6',
                                                        orderModel0.orderId);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: 100,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: primaryColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: const Text("Reject"),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ]),
                                      ));
                            }
                          },
                          leading: Text(
                            orders[index]['order_number'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          title: Text(
                            orderModel0.foodName,
                          ),
                          subtitle: Text(
                            "x ${orderModel0.quantity}",
                          ),
                          trailing: Text(
                              "RM ${orderModel0.foodPrice.toStringAsFixed(2)}"),
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
