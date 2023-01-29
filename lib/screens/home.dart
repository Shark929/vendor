import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/screens/my_menu_screens.dart';
import 'package:vendor/widgets/dashboard_component2.dart';
import 'package:vendor/widgets/dashboard_container1.dart';
import 'package:vendor/widgets/label1.dart';

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
            DashboardContainer2(label: "Revenue", data: "0"),
            const SizedBox(
              height: 10,
            ),
            Label1(
              label: "Total Orders",
              data: "1",
            ),
            const SizedBox(
              height: 10,
            ),
            Label1(
              label: "Total Customers",
              data: "1",
            ),
            const SizedBox(
              height: 10,
            ),
            Label1(
              label: "Dine in",
              data: "1",
            ),
            const SizedBox(
              height: 10,
            ),
            Label1(
              label: "Take away",
              data: "1",
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => MyMenuScreens());
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
