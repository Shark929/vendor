import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';
import 'package:vendor/controllers/location_controller.dart';
import 'package:vendor/controllers/mall_controller.dart';
import 'package:vendor/models/mall_model.dart';

class EditLocationMallScreen extends StatefulWidget {
  const EditLocationMallScreen({super.key});

  @override
  State<EditLocationMallScreen> createState() => _EditLocationMallScreenState();
}

class _EditLocationMallScreenState extends State<EditLocationMallScreen> {
  @override
  Widget build(BuildContext context) {
    String dropdownLocation = "";
    String dropdownMall = "";
    List<String> mylocationList = [];
    List<String> myMallList = [];
    List<MallModel> mylist = [];

    List<String> filterMall = [];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Location & Mall"),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    const Text(
                      "Location: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GetX<LocationController>(
                      init: Get.put(LocationController()),
                      builder: (LocationController lcController) {
                        for (int i = 0; i < lcController.location.length; i++) {
                          if (mylocationList.length <
                                  lcController.location.length ||
                              mylocationList.isEmpty) {
                            mylocationList
                                .add(lcController.location[i].locationName);
                          }
                        }
                        dropdownLocation = mylocationList[0];
                        return DropdownButton(
                          // Initial Value
                          value: dropdownLocation,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: mylocationList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              dropdownLocation = newValue!;
                            });
                            print(dropdownLocation);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Mall: ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  GetX<MallController>(
                    init: Get.put(MallController()),
                    builder: (MallController mcController) {
                      for (int i = 0; i < mcController.mall.length; i++) {
                        if (myMallList.length < mcController.mall.length ||
                            myMallList.isEmpty) {
                          myMallList.add(mcController.mall[i].mall);
                        }
                      }
                      dropdownMall = myMallList[0];
                      return DropdownButton(
                        // Initial Value
                        value: dropdownMall,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: myMallList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            dropdownMall = newValue!;
                          });
                          print(dropdownMall);
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Vendor2FirestoreDb.updateLocationMall(
                      dropdownLocation, dropdownMall, authController.user.uid);
                  Navigator.pop(context);
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
                    "Confirm",
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
      ),
    );
  }
}
