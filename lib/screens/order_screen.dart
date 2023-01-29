import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var acceptList = [];

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
              ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  if (acceptList.isEmpty || acceptList.length < orders.length) {
                    acceptList.add("0");
                  }
                  return ListTile(
                    tileColor: acceptList[index] == "0"
                        ? Colors.white
                        : acceptList[index] == "1"
                            ? Colors.green
                            : Colors.red,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                    'Accept or reject order #${orders[index]['order_number']}'),
                                content: Row(children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        acceptList[index] = "1";
                                      });
                                      print(acceptList[index]);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("Accept"),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        acceptList[index] = "2";
                                      });
                                      print(acceptList[index]);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("Reject"),
                                    ),
                                  )
                                ]),
                              ));
                    },
                    leading: Text(
                      orders[index]['order_number'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    title: Text(
                      orders[index]['item_name'],
                    ),
                    subtitle: Text(
                      "x ${orders[index]['quantity']}",
                    ),
                    trailing: Text("RM ${orders[index]['item_price']}"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
