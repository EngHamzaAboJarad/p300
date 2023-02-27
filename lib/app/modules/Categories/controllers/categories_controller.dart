import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  //TODO: Implement CategoriesController

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
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(docId)
        .delete();
  }
}
