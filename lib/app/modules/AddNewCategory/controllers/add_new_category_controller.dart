import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewCategoryController extends GetxController {
  late TextEditingController nameController;
  RxBool isLoading = false.obs;
  String? fileName;
  String? imgUrl;
  var isImagePicked = false;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
  }

  void increment() => count.value++;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      fileName = result.files.first.name;
      await FirebaseStorage.instance
          .ref('uploads/categories/$fileName')
          .putData(fileBytes);

      isImagePicked = true;

      FirebaseStorage.instance
          .ref('uploads/categories/$fileName')
          .getDownloadURL()
          .then((url) {
        imgUrl = url;
        update();
      });
    }
  }

  Future<void> addNewCategory(String? name, dynamic imagePath) async {
    Map<String, dynamic> demoData = {'name': name, 'image_path': imagePath};
    isLoading.value = true;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('categories');
    collectionReference.add(demoData).then((value) {
      isLoading.value = false;
    });
  }
}
