import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  String shopName;
  String phoneNum;
  String location;
  String mall;
  String profilePicture;
  String email;
  String uid;
  String code;

  VendorModel({
    required this.shopName,
    required this.phoneNum,
    required this.location,
    required this.mall,
    required this.profilePicture,
    required this.email,
    required this.uid,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
        "shopName": shopName,
        "phoneNum": phoneNum,
        "location": location,
        "mall": mall,
        "profilePicture": profilePicture,
        "email": email,
        "uid": uid,
        "code": code,
      };

  static VendorModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VendorModel(
      shopName: snapshot['shopName'],
      phoneNum: snapshot['phoneNum'],
      location: snapshot['location'],
      mall: snapshot['mall'],
      profilePicture: snapshot['profilePicture'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      code: snapshot['code'],
    );
  }
}
