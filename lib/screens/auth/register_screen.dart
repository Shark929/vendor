import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/controllers/auth_controller.dart';
import 'package:vendor/screens/auth/login_screen.dart';
import 'package:vendor/widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController shopNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "Vendor Register",
                  style: TextStyle(
                    fontSize: 24,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: shopNameController,
                label: "Shop name",
                icon: Icons.add_business,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: phoneNumController,
                label: "Phone",
                icon: Icons.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                  controller: emailController,
                  label: "Email",
                  icon: Icons.email),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: passwordController,
                label: "Password",
                icon: Icons.lock,
                isObscure: true,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () => authController.registerVendor(
                  shopName: shopNameController.text,
                  phoneNum: phoneNumController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  // image: File("")
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
