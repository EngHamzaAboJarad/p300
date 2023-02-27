import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/primary_button.dart';
import '../../../global_presentation/global_widgets/primary_text_field.dart';
import '../controllers/add_new_category_controller.dart';

class AddNewCategoryView extends GetView<AddNewCategoryController> {
  AddNewCategoryView({Key? key}) : super(key: key);

  @override
  AddNewCategoryController controller = Get.put(AddNewCategoryController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Category'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                GetBuilder<AddNewCategoryController>(
                  builder: (_) {
                    return InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: controller.imgUrl != null
                          ? Container(
                              height: 300.h,
                              width: 300.h,
                              margin: const EdgeInsets.all(50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                    '${controller.imgUrl}',
                                  ))),
                            )
                          : Container(
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
                    );
                  },
                ),
                GetBuilder<AddNewCategoryController>(
                  builder: (_) => controller.isImagePicked == false
                      ? const PrimaryText(
                          'Please pick an image',
                          color: Colors.white,
                          fontSize: 6,
                        )
                      : const SizedBox(),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 35.h),
                  child: SizedBox(
                    height: 100.h,
                    width: 250.w,
                    child: PrimaryTextField(
                        hintText: 'Category Name',
                        controller: controller.nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Category Name';
                          }
                          return null;
                        }),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: SizedBox(
                    height: 100.h,
                    width: 250.w,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: 80.h,
                          width: 190.w,
                          child: PrimaryButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  controller.isImagePicked == true) {
                                controller.addNewCategory(
                                    controller.nameController.text,
                                    controller.imgUrl);
                                Get.back();
                                controller.nameController.clear();
                              }
                            },
                            title: 'Add',
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
