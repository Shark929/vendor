import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/item_firestore_db.dart';
import 'package:vendor/controllers/item_controller.dart';
import 'package:vendor/screens/add_menu_screens.dart';

class MyMenuScreens extends StatelessWidget {
  const MyMenuScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("My Menu"),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: GetX<ItemController>(
                init: Get.put(ItemController()),
                builder: (ItemController itemController) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemController.items.length,
                    itemBuilder: (context, index) {
                      final itemModel0 = itemController.items[index];

                      if (itemModel0.vendorId == authController.user.uid) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ListTile(
                            onTap: () {
                              ItemFirestoreDb.updateMenuAvailable(
                                  !itemModel0.availabilityCode,
                                  itemModel0.itemId);
                            },
                            leading: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(itemModel0.itemPicture),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            title: Text(
                              itemModel0.itemName,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(itemModel0.itemDescription),
                                Text(itemModel0.availabilityCode == true
                                    ? "Available"
                                    : "Not available"),
                              ],
                            ),
                            trailing: Text(
                              "RM ${double.parse(itemModel0.itemPrice).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: InkWell(
                onTap: () {
                  Get.to(() => AddMenuScreen());
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
                    "Add Menu",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
