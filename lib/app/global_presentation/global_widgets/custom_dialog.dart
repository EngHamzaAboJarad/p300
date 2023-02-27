import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';

showMyDialog({
  String? title,
  String? content,
  String? actionTitle1,
  String? actionTitle2,
  Function()? actionFunction1,
  Function()? actionFunction2,
}) {
  Get.defaultDialog(
    backgroundColor: ColorManager.bgColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    title: title ?? "General Dialog",
    content: Text(content ?? ""),
    actions: [
      TextButton(
        onPressed: actionFunction1,
        child: Text(
          actionTitle1 ?? '',
          style: TextStyle(
            color: ColorManager.primary,
          ),
        ),
      ),
      TextButton(
        onPressed: actionFunction2,
        child: Text(
          actionTitle2 ?? '',
          style: TextStyle(
            color: ColorManager.primary,
          ),
        ),
      ),
    ],
  );
}
