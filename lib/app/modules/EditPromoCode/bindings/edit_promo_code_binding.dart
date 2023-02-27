import 'package:get/get.dart';

import '../controllers/edit_promo_code_controller.dart';

class EditPromoCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPromoCodeController>(
      () => EditPromoCodeController(),
    );
  }
}
