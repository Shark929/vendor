import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';
import 'package:vendor/screens/edit_location_mall_screen.dart';
import 'package:vendor/widgets/edit_input_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  TextEditingController phoneController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              EditInputField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                label: "Phone",
                hintText: "012345678",
                doneFunction: () {
                  print("done");
                },
              ),
              const SizedBox(
                height: 20,
              ),
              EditInputField(
                keyboardType: TextInputType.text,
                controller: openTimeController,
                label: "Open Hour",
                hintText: "10:00",
                doneFunction: () {
                  Vendor2FirestoreDb.updateOpenTime(
                      openTimeController.text, authController.user.uid);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              EditInputField(
                keyboardType: TextInputType.text,
                controller: closeTimeController,
                label: "Close Hour",
                hintText: "10:00",
                doneFunction: () {
                  Vendor2FirestoreDb.updateCloseTime(
                      closeTimeController.text, authController.user.uid);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => EditLocationMallScreen());
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text("Edit location & mall"),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                        )
                      ],
                    )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
