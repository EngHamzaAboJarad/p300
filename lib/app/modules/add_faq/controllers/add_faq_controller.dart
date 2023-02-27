import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFaqController extends GetxController {
  late TextEditingController questionController;
  late TextEditingController answerController;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    questionController = TextEditingController();
    answerController = TextEditingController();
  }

  @override
  void onClose() {
    questionController.dispose();
    answerController.dispose();
  }

  Future<void> addNewFaq(String? question, dynamic answer) async {
    Map<String, dynamic> faqData = {'question': question, 'answer': answer};
    isLoading.value = true;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('faqs');
    collectionReference.add(faqData).then((value) {
      isLoading.value = false;
    });
  }
}
