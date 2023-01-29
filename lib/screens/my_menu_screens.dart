import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/constants/constants.dart';
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
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Image.network(
                          menus[index]['item_image'],
                        ),
                        title: Text(menus[index]['item_name']),
                        subtitle: Text(
                          menus[index]['item_description'],
                        ),
                        trailing: Text(
                          menus[index]['item_price'],
                        ),
                      ),
                    );
                  }),
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
