import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_features/color_manager.dart';

showMySnackBar(String title,String message){
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: ColorManager.primary,
    borderRadius: 20,
    margin:const  EdgeInsets.all(15),
    colorText: Colors.white,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.vertical,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

