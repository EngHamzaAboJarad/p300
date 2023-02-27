import 'package:get/get.dart';

import '../controllers/contact_messages_controller.dart';

class ContactMessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactMessagesController>(
      () => ContactMessagesController(),
    );
  }
}
