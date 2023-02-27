import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PromoCodesController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  static Future<void> deleteData(String? docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('promo_code')
          .doc(docId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
