import 'package:get/get.dart';
import 'package:vendor/constants/dashboard_firestore_db.dart';
import 'package:vendor/models/dashboard_model.dart';

class DashboardController extends GetxController {
  Rx<List<DashboardModel>> dashboard = Rx<List<DashboardModel>>([]);

  List<DashboardModel> get dashboardList => dashboard.value;

  @override
  void onReady() {
    dashboard.bindStream(DashboardFirestoreDb.dashboardStream());
  }
}
