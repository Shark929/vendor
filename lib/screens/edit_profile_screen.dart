import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/constants/vendor_firestore_db.dart';
import 'package:vendor/screens/edit_location_mall_screen.dart';
import 'package:vendor/widgets/edit_input_field.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController openTimeController = TextEditingController();

  TextEditingController closeTimeController = TextEditingController();
  //upload image
  FirebaseStorage storage = FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
        Navigator.pop(context);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = Path.basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);
      UploadTask uploadTask = ref.putFile(_photo!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      Vendor2FirestoreDb.updateImage(downloadUrl, authController.user.uid);
    } catch (e) {
      print('error occured');
    }
  }

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
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: IconButton(
                      onPressed: () {
                        imgFromGallery();
                        // Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
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
                  Get.to(() => const EditLocationMallScreen());
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: const [
                        Text("Edit location & mall"),
                        Spacer(),
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
