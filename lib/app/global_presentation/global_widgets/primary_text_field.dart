import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global_features/color_manager.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool? multiLines;

  const PrimaryTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onTap,
    this.onChange,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.multiLines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 50,
      child: Material(
        shadowColor: ColorManager.secondaryColor,
        elevation: 4,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: multiLines! ? 10 : 1,
          cursorColor: ColorManager.primary,
          style: const TextStyle(color: Colors.white),
          keyboardType: keyboardType,
          onTap: onTap ?? () {},
          onChanged: onChange ?? (v) {},
          onFieldSubmitted: onFieldSubmitted ?? (v) {},
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText!.isNotEmpty ? hintText! : '',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 10.sp,
              ),
              filled: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              fillColor: ColorManager.secondaryColor),
          validator: validator,
        ),
      ),
    );
  }
}
