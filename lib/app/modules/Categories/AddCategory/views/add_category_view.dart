import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';

import '../../../../global_presentation/global_features/color_manager.dart';
import '../controllers/categories_add_category_controller.dart';

class AddCategoryView extends GetView<CategoriesAddCategoryController> {
  const AddCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Add Category',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
          Container(
            height: 300.h,
            width: 300.h,
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: ColorManager.secondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(Icons.camera),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: PrimaryTextField(
              hintText: "Category Name",
              controller: TextEditingController(),
              validator: (v) {},
            ),
          ),
          SizedBox(
            height: 90.h,
          ),
          SizedBox(
            height: 80.h,
            width: 190.w,
            child: PrimaryButton(
              title: "Add",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
