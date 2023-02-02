import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';
import 'package:vendor/controllers/vendor_controller.dart';
import 'package:vendor/screens/edit_profile_screen.dart';

import '../controllers/profile_controller.dart';

class ProfileScreens extends StatefulWidget {
  final String uid;
  ProfileScreens({super.key, required this.uid});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Profile"),
        ),
        body: GetX<Vendor2Controller>(
            init: Get.put(Vendor2Controller()),
            builder: (Vendor2Controller vendor2Controller) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: vendor2Controller.vendor.length,
                  itemBuilder: (context, index) {
                    final vendorModel0 = vendor2Controller.vendor[index];
                    if (vendorModel0.vendorId == authController.user.uid) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Vendor2FirestoreDb.updateShop(
                                          !vendorModel0.isOpen,
                                          authController.user.uid);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        vendorModel0.isOpen == false
                                            ? "Closed"
                                            : "Open",
                                        style: TextStyle(
                                          color: vendorModel0.isOpen == false
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () {
                                        Get.to(() => EditProfileScreen());
                                      },
                                      child: const Text("Edit profile")),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  vendorModel0.vendorRestaurantName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Location: ${vendorModel0.vendorLocation}"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Mall: ${vendorModel0.vendorMall}"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "open hour: ${vendorModel0.openHour} AM"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "close hour: ${vendorModel0.closeHour} PM"),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () {
                                  authController.signOut();
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
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  });
            }),
      ),
    );
  }
}
