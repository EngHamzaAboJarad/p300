import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPromoCodeController extends GetxController {
  dynamic argumentData = Get.arguments;

  late TextEditingController keyController;
  late TextEditingController percentController;
  RxString docId = ''.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    keyController = TextEditingController();
    percentController = TextEditingController();
    docId.value = argumentData[0]['docId'];
    keyController.text = argumentData[1]['key'];
    percentController.text = argumentData[2]['percentage'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    keyController.dispose();
    percentController.dispose();
  }

  Future<void> updateData(
      String? docId, String? key, dynamic percentage) async {
    try {
      isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('promo_code')
          .doc(docId)
          .update({'key': key, 'percentage': percentage});

      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
