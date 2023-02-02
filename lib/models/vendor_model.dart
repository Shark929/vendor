import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  String? vendorId;
  late String vendorRestaurantName;
  late String vendorPhone;
  late String vendorEmail;
  late String vendorLocation;
  late String vendorMall;
  late String vendorImage;
  late bool isAuthorise;
  late bool isOpen;
  late String openHour;
  late String closeHour;

  VendorModel({
    this.vendorId,
    required this.vendorRestaurantName,
    required this.vendorEmail,
    required this.vendorPhone,
    required this.vendorLocation,
    required this.vendorMall,
    required this.vendorImage,
    required this.isAuthorise,
    required this.isOpen,
    required this.openHour,
    required this.closeHour,
  });

  Map<String, dynamic> toJson() => {
        "vendorRestaurantName": vendorRestaurantName,
        "vendorPhone": vendorPhone,
        "vendorLocation": vendorLocation,
        "vendorMall": vendorMall,
        "vendorImage": vendorImage,
        "vendorEmail": vendorEmail,
        "vendorId": vendorId,
        "isAuthorise": isAuthorise,
        "isOpen": isOpen,
        "openHour": openHour,
        "closeHour": closeHour,
      };

  static VendorModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VendorModel(
      vendorRestaurantName: snapshot['vendorRestaurantName'],
      vendorPhone: snapshot['vendorPhone'],
      vendorLocation: snapshot['vendorLocation'],
      vendorMall: snapshot['vendorMall'],
      vendorImage: snapshot['vendorImage'],
      vendorEmail: snapshot['vendorEmail'],
      vendorId: snapshot['vendorId'],
      isAuthorise: snapshot['isAuthorise'],
      isOpen: snapshot['isOpen'],
      openHour: snapshot['openHour'],
      closeHour: snapshot['closeHour'],
    );
  }
}
