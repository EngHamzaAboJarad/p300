import 'package:flutter/material.dart';

import '../global_features/color_manager.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    this.hint,
  }) : super(key: key);
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint ?? '',
        fillColor: ColorManager.secondaryColor,
        filled: true,
        suffixIcon: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: const Icon(Icons.search),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
