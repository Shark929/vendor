import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/vendor_model.dart';
import 'package:vendor/screens/auth/login_screen.dart';
import 'package:vendor/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  //set initial screen
  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //pick image
  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      Get.snackbar(
        "Profile Picture",
        "Successfully selected your profile picture!",
      );
    }

    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload to firebase storage
  Future<String> uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePicture')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //register user
  void registerVendor(
      {required String shopName,
      required String phoneNum,
      required String email,
      required String password,
      required File? image}) async {
    try {
      if (shopName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        //save our user data into AUTH & firebase firestore
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        // String downloadUrl = await uploadToStorage(image);

        VendorModel user = VendorModel(
          profilePicture: '',
          email: email,
          uid: userCredential.user!.uid,
          code: "0",
          location: '',
          mall: '',
          phoneNum: phoneNum,
          shopName: shopName,
        );
        await firebaseFirestore
            .collection('vendors')
            .doc(userCredential.user!.uid)
            .set(
              user.toJson(),
            );
      } else {
        Get.snackbar("Error creating an account", "Please enter all fields");
      }
    } catch (e) {
      Get.snackbar("Error creating an account", e.toString());
    }
  }

  //login user
  void loginVendor({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("Vendor Logged In");
      } else {
        Get.snackbar("Error creating an account", "Please enter all fields");
      }
    } catch (e) {
      Get.snackbar("Error creating an account", e.toString());
    }
  }

  //sign out user
  void signOut() async {
    await firebaseAuth.signOut();
  }
}
