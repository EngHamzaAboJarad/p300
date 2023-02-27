import 'package:get/get.dart';

import '../controllers/edit_faq_controller.dart';

class EditFaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditFaqController>(
      () => EditFaqController(),
    );
  }
}
