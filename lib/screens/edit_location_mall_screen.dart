import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';
import 'package:vendor/controllers/auth_controller.dart';

class EditLocationMallScreen extends StatefulWidget {
  const EditLocationMallScreen({super.key});

  @override
  State<EditLocationMallScreen> createState() => _EditLocationMallScreenState();
}

class _EditLocationMallScreenState extends State<EditLocationMallScreen> {
  String dropdownLocation = location[0];

  String dropdownMall = mall[0];

  @override
  Widget build(BuildContext context) {
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
              Row(
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
                  DropdownButton(
                    // Initial Value
                    value: dropdownLocation,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: location.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownLocation = newValue!;
                      });
                    },
                  ),
                ],
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
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    // Initial Value
                    value: dropdownMall,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: mall.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownMall = newValue!;
                      });
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
