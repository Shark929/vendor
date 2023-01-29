import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/widgets/edit_input_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  TextEditingController phoneController = TextEditingController();
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
            ]),
          ),
        ),
      ),
    );
  }
}
