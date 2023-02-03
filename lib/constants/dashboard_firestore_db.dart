import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/constants/constants.dart';
import 'package:vendor/models/dashboard_model.dart';

class DashboardFirestoreDb {
  //create

  //read
  static Stream<List<DashboardModel>> dashboardStream() {
    return firebaseFirestore
        .collection('dashboard')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<DashboardModel> dashboards = [];
      for (var dashboard in querySnapshot.docs) {
        final dashboardModel = DashboardModel.fromDocumentSnapshot(dashboard);
        dashboards.add(dashboardModel);
      }

      return dashboards;
    });
  }

  //update
  //total orders
  static updateTotalOrders(String newOrders, documentId) {
    firebaseFirestore.collection('dashboard').doc(documentId).update(
      {
        'totalOrders': newOrders,
      },
    );
  }

  //total customers
  static updateTotalCustomers(String newCustomers, documentId) {
    firebaseFirestore.collection('dashboard').doc(documentId).update(
      {
        'totalCustomers': newCustomers,
      },
    );
  }

  // dine in number
  static updateDineIn(String newDineIn, documentId) {
    firebaseFirestore.collection('dashboard').doc(documentId).update(
      {
        'dineIn': newDineIn,
      },
    );
  }

  //take away number
  static updatetakeAway(String newTakeAway, documentId) {
    firebaseFirestore.collection('dashboard').doc(documentId).update(
      {
        'takeAway': newTakeAway,
      },
    );
  }
  //delete
}
