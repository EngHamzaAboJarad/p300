import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  //TODO: Implement NotificationsController
  late TextEditingController textController;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    textController.dispose();
  }

  Future<void> addNewNotification(String? text) async {
    Map<String, dynamic> notificationData = {
      'text': text,
      'date': DateTime.now()
    };
    isLoading.value = true;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('notifications');
    collectionReference.add(notificationData).then((value) {
      isLoading.value = false;
    });
  }

  static Future<void> deleteRow(String? docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(docId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
