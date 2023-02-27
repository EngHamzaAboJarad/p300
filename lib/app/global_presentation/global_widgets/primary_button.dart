import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global_features/color_manager.dart';
import '../global_features/global_features/font_manager.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final Color? color;
  final double? fontSize;

  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.color,
      this.fontSize = 11})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title!,
        style: TextStyle(
            fontSize: fontSize!.sp,
            color: Colors.white,
            fontWeight: FontWeightManager.medium),
      ),
      style: ElevatedButton.styleFrom(
        primary: color ?? ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
      ),
    );
  }
}
