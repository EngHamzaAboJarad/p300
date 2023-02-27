import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  dynamic argumentData = Get.arguments;

  late TextEditingController nameController;
  RxString docId = ''.obs;
  RxBool isLoading = false.obs;
  RxString imgUrl = ''.obs;
  String? fileName;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    docId.value = argumentData[0]['docId'];
    nameController.text = argumentData[1]['name'];
    imgUrl.value = argumentData[2]['image_path'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      fileName = result.files.first.name;
      await FirebaseStorage.instance
          .ref('uploads/categories/$fileName')
          .putData(fileBytes);

      FirebaseStorage.instance
          .ref('uploads/categories/$fileName')
          .getDownloadURL()
          .then((url) {
        imgUrl.value = url;
        print(imgUrl);
      });
    }
  }

  Future<void> updateData(String? docId, String? name, dynamic imgPath) async {
    try {
      isLoading.value = true;
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(docId)
          .update({'name': name, 'image_path': imgPath});

      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }
}
