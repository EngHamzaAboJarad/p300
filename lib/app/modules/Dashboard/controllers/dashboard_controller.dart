import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../packages/controllers/packages_controller.dart';

class DashboardController extends GetxController {
  static RxInt ordersCounter = 0.obs;
  RxInt categoryCounter = 0.obs;
  RxInt packageCounter = 0.obs;
  @override
  void onInit() {
    super.onInit();
    ordersCount();
    categoryCount();
    packageCount();
  }

  @override
  void onReady() {
    super.onReady();
  }

  static Future<int> ordersCount() async =>
      FirebaseFirestore.instance.collection('orders').get().then((value) {
        ordersCounter.value = value.docs.length;
        return ordersCounter.value;
      });

  Future<int> categoryCount() async =>
      FirebaseFirestore.instance.collection('categories').get().then((value) {
        categoryCounter.value = value.docs.length;
        return categoryCounter.value;
      });

  Future<int> packageCount() async =>
      FirebaseFirestore.instance.collection('packages').get().then((value) {
        packageCounter.value = value.docs.length;
        return packageCounter.value;
      });
}
