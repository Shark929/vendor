import 'package:flutter/material.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/item_firestore_db.dart';
import 'package:vendor/models/item_model.dart';
import 'package:vendor/widgets/input_field.dart';

class AddMenuScreen extends StatefulWidget {
  AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  TextEditingController priceController = TextEditingController();

  TextEditingController itemNameController = TextEditingController();

  TextEditingController itemDescriptionController = TextEditingController();
// Initial Selected Value
  String dropdowncategory = category[0];
  String dropdowncuisine = cuisines[0];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Add Menu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => authController.pickImage(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                      ),
                      Text("Add image"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: itemNameController,
                label: "Item name",
                icon: Icons.label,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: itemDescriptionController,
                label: "Item description",
                icon: Icons.label,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputField(
                keyboardType: TextInputType.number,
                controller: priceController,
                label: "RM 0.00",
                icon: Icons.label,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cuisines & Category",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  DropdownButton(
                    // Initial Value
                    value: dropdowncuisine,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: cuisines.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdowncuisine = newValue!;
                      });
                    },
                  ),
                  const Spacer(),
                  DropdownButton(
                    // Initial Value
                    value: dropdowncategory,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: category.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdowncategory = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  final itemModel = ItemModel(
                    itemName: itemNameController.text,
                    itemPrice: priceController.text,
                    itemDescription: itemDescriptionController.text,
                    itemCategory: dropdowncategory,
                    itemPicture: '',
                    itemCuisineType: dropdowncuisine,
                    uid: authController.user.uid,
                    availabilityCode: true,
                    vendorId: authController.user.uid,
                  );
                  await ItemFirestoreDb.addItem(itemModel);
                  // amountController.clear();
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
            ],
          ),
        ),
      ),
    ));
  }
}
