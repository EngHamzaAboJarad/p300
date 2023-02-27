import 'package:get/get.dart';

import '../controllers/add_promo_code_controller.dart';

class AddPromoCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPromoCodeController>(
      () => AddPromoCodeController(),
    );
  }
}
