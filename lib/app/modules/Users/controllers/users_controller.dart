import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  //TODO: Implement UsersController

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

  static Future<void> deleteCategory(String? docId) async {
    await FirebaseFirestore.instance.collection('users').doc(docId).delete();
  }
}
