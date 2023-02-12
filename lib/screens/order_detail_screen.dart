import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/customer_order_firestoredb.dart';
import 'package:vendor/constants/dashboard_firestore_db.dart';
import 'package:vendor/constants/order_history_firebasedb.dart';
import 'package:vendor/constants/revenue_firestore_db.dart';
import 'package:vendor/constants/wallet_balance_firestore_db.dart';
import 'package:vendor/controllers/dashboard_controller.dart';
import 'package:vendor/controllers/new_order_detail_controller.dart';
import 'package:vendor/controllers/revenue_controller.dart';
import 'package:vendor/controllers/wallet_balance_controller.dart';
import 'package:vendor/models/customer_cart_model.dart';
import 'package:vendor/models/new_order_model.dart';
import 'package:vendor/screens/chat_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderNumber;
  final NewOrderModel model;
  const OrderDetailScreen(
      {super.key, required this.orderNumber, required this.model});

  @override
  Widget build(BuildContext context) {
    double getRevenue = 0.0;
    String getTotalOrder = "";
    String getTotalCustomer = "";
    String getTotalDineIn = "";
    String getTotalTakeAway = "";
    List<int> getQuantity = [];
    String getCartId = "";
    String getVendorWalletBalance = "";
    List<MyCartModel> myCartList = [];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(orderNumber),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            GetX<OrderItemController2>(
                init: Get.put(OrderItemController2(orderNumber: orderNumber)),
                builder: (OrderItemController2 oController) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: oController.order.length,
                      itemBuilder: (context, index) {
                        final oc = oController.order[index];
                        getCartId = oc.myCartId!;
                        if (myCartList.isEmpty ||
                            myCartList.length < oController.order.length) {
                          myCartList.add(oc);
                        }
                        getQuantity.add(oc.quantity);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(oc.itemPicture),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            title: Text(oc.itemName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("X${oc.quantity}"),
                                Text("RM ${oc.itemPrice}")
                              ],
                            ),
                            trailing: Text(
                              "RM ${oc.totalPrice}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      });
                }),
            const SizedBox(
              height: 20,
            ),

            //get revenue
            GetX<RevenueController>(
                init: Get.put(RevenueController()),
                builder: (RevenueController rController) {
                  for (int i = 0; i < rController.revenueList.length; i++) {
                    if (rController.revenueList[i].vendorId ==
                        authController.user.uid) {
                      getRevenue =
                          double.parse(rController.revenueList[i].balance);
                    }
                  }
                  return const SizedBox();
                }),

            //get dashbboard
            GetX<DashboardController>(
              init: Get.put(DashboardController()),
              builder: (DashboardController dController) {
                for (int i = 0; i < dController.dashboardList.length; i++) {
                  if (dController.dashboardList[i].vendorId ==
                      authController.user.uid) {
                    getTotalOrder = dController.dashboardList[i].totalOrders;
                    getTotalCustomer =
                        dController.dashboardList[i].totalCustomers;
                    getTotalDineIn = dController.dashboardList[i].dineIn;
                    getTotalTakeAway = dController.dashboardList[i].takeAway;
                  }
                }
                return const SizedBox();
              },
            ),

            //get vendor wallet balance

            GetX<WalletBalanceController>(
              init: Get.put(WalletBalanceController()),
              builder: (WalletBalanceController wbController) {
                for (int i = 0; i < wbController.walletBalance.length; i++) {
                  if (wbController.walletBalance[i].vendorId ==
                      authController.user.uid) {
                    getVendorWalletBalance =
                        wbController.walletBalance[i].balance;
                  }
                }
                return const SizedBox();
              },
            ),
            model.code == "1"
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            NewOrderFirestoreDb.updateCode(orderNumber, "2");
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),
                            child: const Text(
                              "Accept",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => ChatScreen(
                                vendorId: model.vendorId,
                                customerId: model.customerId,
                                chatRoomId:
                                    "${model.vendorId}&&${model.customerId}",
                                orderNumber: model.orderNumber,
                                totalPrice: model.totalPrice,
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: 3),
                              borderRadius: BorderRadius.circular(10),
                              // color: primaryColor,
                            ),
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : model.code == "2"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            NewOrderFirestoreDb.updateCode(orderNumber, "3");
                            Navigator.pop(context);
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
                              "Set in progress",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    : model.code == "3"
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: InkWell(
                              onTap: () {
                                NewOrderFirestoreDb.updateCode(
                                    orderNumber, "4");

                                //update dashboard

                                //calculate revenue
                                getRevenue =
                                    getRevenue + double.parse(model.totalPrice);
                                print(getRevenue.toStringAsFixed(2));
                                //update revenue
                                RevenueFirestoreDb.updateRevenueAmount(
                                    getRevenue.toStringAsFixed(2),
                                    authController.user.uid);

                                //calculate total orders
                                int totalQuantity = 0;
                                for (int i = 0; i < getQuantity.length; i++) {
                                  totalQuantity += getQuantity[i];
                                }

                                getTotalOrder =
                                    (int.parse(getTotalOrder) + totalQuantity)
                                        .toString();

                                print(getTotalOrder);
                                //calculate total customers
                                getTotalCustomer =
                                    (int.parse(getTotalCustomer) + 1)
                                        .toString();

                                print(getTotalCustomer);

                                //calculate dine in

                                //calculate take away

                                if (model.isDineIn == false) {
                                  getTotalTakeAway =
                                      (int.parse(getTotalTakeAway) + 1)
                                          .toString();
                                } else {
                                  getTotalDineIn =
                                      (int.parse(getTotalDineIn) + 1)
                                          .toString();
                                }

                                print(getTotalTakeAway);
                                print(getTotalDineIn);
                                DashboardFirestoreDb.updateDineIn(
                                    getTotalDineIn, authController.user.uid);
                                DashboardFirestoreDb.updatetakeAway(
                                    getTotalTakeAway, authController.user.uid);
                                DashboardFirestoreDb.updateTotalOrders(
                                    getTotalOrder, authController.user.uid);
                                DashboardFirestoreDb.updateTotalCustomers(
                                    getTotalCustomer, authController.user.uid);

                                //update vendor wallet balacne

                                /**
                                 * 1. once get the vendor wallet balance
                                 * 2. update it with the total amount
                                 */
                                getVendorWalletBalance =
                                    (double.parse(getVendorWalletBalance) +
                                            double.parse(model.totalPrice))
                                        .toStringAsFixed(2);
                                print(getVendorWalletBalance);
                                WalletBalanceFirestoreDb.updateAmount(
                                    getVendorWalletBalance,
                                    authController.user.uid);
                                Navigator.pop(context);
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
                                  "Set completed",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : model.code == "4"
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    NewOrderFirestoreDb.updateCode(
                                        orderNumber, "5");

                                    /**
                                     * 1. Once the code is updated to 5,
                                     * 2. Move all the items into a history database
                                     * 3. Delete current docs
                                     */

                                    for (var e in myCartList) {
                                      OrderHistoryFirestoreDb.addOrderHistory(
                                          e);
                                    }
                                    NewOrderFirestoreDb.deleteOrderList(
                                        orderNumber, getCartId);
                                    NewOrderFirestoreDb.deleteOrder(
                                        orderNumber);
                                    Navigator.pop(context);
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
                                      "Close",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
          ],
        ),
      ),
    ));
  }
}
