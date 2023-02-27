import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FaqsController extends GetxController {
  //TODO: Implement FaqsController

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

  static Future<void> deleteRow(String? docId) async {
    try {
      await FirebaseFirestore.instance.collection('faqs').doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
