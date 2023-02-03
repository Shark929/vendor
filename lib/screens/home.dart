import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/controllers/dashboard_controller.dart';
import 'package:vendor/controllers/revenue_controller.dart';
import 'package:vendor/screens/my_menu_screens.dart';
import 'package:vendor/widgets/dashboard_component.dart';
import 'package:vendor/widgets/dashboard_component2.dart';
import 'package:vendor/widgets/dashboard_container1.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardContainer1(
                  data: '1',
                  label: 'Day',
                ),
                DashboardContainer1(
                  data: '1',
                  label: 'Month',
                ),
                DashboardContainer1(
                  data: '1',
                  label: 'Year',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GetX<RevenueController>(
              init: Get.put(RevenueController()),
              builder: (RevenueController wbController) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: wbController.revenueList.length,
                    itemBuilder: (context, index) {
                      final revenue0 = wbController.revenueList[index];
                      if (revenue0.vendorId == authController.user.uid) {
                        return DashboardContainer2(
                            label: "Revenue",
                            data:
                                "RM ${double.parse(revenue0.balance).toStringAsFixed(2)}");
                      } else {
                        return const SizedBox();
                      }
                    });
              },
            ),
            GetX<DashboardController>(
                init: Get.put(DashboardController()),
                builder: (DashboardController dashboardController) {
                  int dashLength = dashboardController.dashboardList.length;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: dashLength,
                      itemBuilder: (context, index) {
                        final dashModel0 =
                            dashboardController.dashboardList[index];
                        if (dashModel0.vendorId == authController.user.uid) {
                          return DashboardComponent(
                              totalOrders: dashModel0.totalOrders,
                              totalCustomers: dashModel0.totalCustomers,
                              dineIn: dashModel0.dineIn,
                              takeAway: dashModel0.takeAway);
                        }
                        return const SizedBox();
                      });
                }),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const MyMenuScreens());
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
                  "My Menu",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
