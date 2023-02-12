import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/controllers/new_order_controller.dart';

import 'order_detail_screen.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: primaryColor,
      ),
      body: GetX<NewOrderController>(
          init: Get.put(NewOrderController()),
          builder: (NewOrderController nController) {
            bool checkVendor = false;
            for (int i = 0; i < nController.order.length; i++) {
              if (nController.order[i].vendorId == authController.user.uid) {
                checkVendor = true;
              }
            }
            if (checkVendor) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: nController.order.length,
                  itemBuilder: (context, index) {
                    if (nController.order[index].vendorId ==
                        authController.user.uid) {
                      final model = nController.order[index];
                      return ListTile(
                        tileColor:
                            model.code == "4" ? primaryColor : Colors.white,
                        onTap: () {
                          Get.to(() => OrderDetailScreen(
                              orderNumber: model.orderId!, model: model));
                        },
                        title: Text(model.orderNumber),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      );
                    }
                    return const SizedBox();
                  });
            }
            return const Center(child: Text("No order from customers"));
          }),
    ));
  }
}
