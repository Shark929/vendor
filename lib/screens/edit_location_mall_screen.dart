import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';

class EditLocationMallScreen extends StatefulWidget {
  const EditLocationMallScreen({super.key});

  @override
  State<EditLocationMallScreen> createState() => _EditLocationMallScreenState();
}

class _EditLocationMallScreenState extends State<EditLocationMallScreen> {
  var dropdownLocation = location[0];
  var dropdownMall = mall[0];
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
                    DropdownButton(
                      value: dropdownLocation,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: location.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownLocation = newValue!;
                        });
                        print(dropdownLocation);
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
                  DropdownButton(
                    value: dropdownMall,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: mall.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownMall = newValue!;
                      });
                      print(dropdownLocation);
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
