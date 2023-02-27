import 'package:get/get.dart';

import '../controllers/categories_add_category_controller.dart';

class CategoriesAddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesAddCategoryController>(
      () => CategoriesAddCategoryController(),
    );
  }
}
