import 'package:flutter/material.dart';
import 'package:vendor/widgets/label1.dart';

class DashboardComponent extends StatelessWidget {
  final String totalOrders, totalCustomers, dineIn, takeAway;
  const DashboardComponent(
      {super.key,
      required this.totalOrders,
      required this.totalCustomers,
      required this.dineIn,
      required this.takeAway});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Label1(
          label: "Total Orders",
          data: totalOrders,
        ),
        const SizedBox(
          height: 10,
        ),
        Label1(
          label: "Total Customers",
          data: totalCustomers,
        ),
        const SizedBox(
          height: 10,
        ),
        Label1(
          label: "Dine in",
          data: dineIn,
        ),
        const SizedBox(
          height: 10,
        ),
        Label1(
          label: "Take away",
          data: takeAway,
        ),
      ],
    );
  }
}
