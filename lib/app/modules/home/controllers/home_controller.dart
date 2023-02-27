import 'package:get/get.dart';
import 'package:home_away_dashboard/app/modules/Dashboard/controllers/dashboard_controller.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    DashboardController.ordersCount();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
