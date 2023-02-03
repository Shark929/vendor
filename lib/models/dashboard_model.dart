import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardModel {
  late String totalOrders;
  late String totalCustomers;
  late String dineIn;
  late String takeAway;
  late String vendorId;

  DashboardModel({
    required this.totalOrders,
    required this.totalCustomers,
    required this.dineIn,
    required this.takeAway,
    required this.vendorId,
  });

  DashboardModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    totalOrders = documentSnapshot['totalOrders'];
    totalCustomers = documentSnapshot['totalCustomers'];
    dineIn = documentSnapshot['dineIn'];
    takeAway = documentSnapshot['takeAway'];
    vendorId = documentSnapshot['vendorId'];
  }
}
