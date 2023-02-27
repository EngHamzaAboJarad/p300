import 'package:get/get.dart';

import '../controllers/promo_codes_controller.dart';

class PromoCodesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoCodesController>(
      () => PromoCodesController(),
    );
  }
}
