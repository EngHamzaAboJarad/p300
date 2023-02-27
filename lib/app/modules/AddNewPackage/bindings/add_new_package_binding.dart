import 'package:get/get.dart';

import '../controllers/add_new_package_controller.dart';

class AddNewPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewPackageController>(
      () => AddNewPackageController(),
    );
  }
}
