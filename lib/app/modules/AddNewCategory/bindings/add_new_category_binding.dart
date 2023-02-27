import 'package:get/get.dart';

import '../controllers/add_new_category_controller.dart';

class AddNewCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewCategoryController>(
      () => AddNewCategoryController(),
    );
  }
}
