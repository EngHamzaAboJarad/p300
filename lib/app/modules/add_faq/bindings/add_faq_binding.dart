import 'package:get/get.dart';

import '../controllers/add_faq_controller.dart';

class AddFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFaqController>(
      () => AddFaqController(),
    );
  }
}
