import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditFaqController extends GetxController {
  //TODO: Implement EditFaqController
  dynamic argumentData = Get.arguments;

  late TextEditingController questionController;
  late TextEditingController answerController;
  RxBool isLoading = false.obs;
  RxString docId = ''.obs;
  @override
  void onInit() {
    super.onInit();
    questionController = TextEditingController();
    answerController = TextEditingController();
    docId.value = argumentData[0]['docId'];
    questionController.text = argumentData[1]['question'];
    answerController.text = argumentData[2]['answer'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    questionController.dispose();
    answerController.dispose();
  }

  Future<void> updateFaqData(
      String? docId, String? question, dynamic answer) async {
    try {
      isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('faqs')
          .doc(docId)
          .update({'question': question, 'answer': answer});

      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
