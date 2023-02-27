import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPromoCodeController extends GetxController {
  //TODO: Implement AddPromoCodeController

  late TextEditingController keyController;
  late TextEditingController percentController;
  RxBool isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    keyController = TextEditingController();
    percentController = TextEditingController();
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

  void increment() => count.value++;

  Future<void> addNewPromoCode(String? key, dynamic percentage) async {
    Map<String, dynamic> demoData = {'key': key, 'percentage': percentage};
    isLoading.value = true;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('promo_code');
    collectionReference.add(demoData).then((value) {
      isLoading.value = false;
    });
  }
}
