import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/controllers/order_history_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Order history"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GetX<OrderHistoryController>(
                init: Get.put(OrderHistoryController()),
                builder: (OrderHistoryController ohController) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: ohController.orderHistory.length,
                      itemBuilder: (context, index) {
                        final ohModel = ohController.orderHistory[index];
                        if (ohModel.vendorId == authController.user.uid) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(ohModel.itemPicture),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              title: Text(ohModel.itemName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("X${ohModel.quantity}"),
                                  Text("RM ${ohModel.itemPrice}")
                                ],
                              ),
                              trailing: Text(
                                "RM ${ohModel.totalPrice}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      });
                })
          ],
        ),
      ),
    ));
  }
}
