import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/primary_button.dart';
import '../../../global_presentation/global_widgets/primary_text_field.dart';
import '../controllers/edit_category_controller.dart';

class EditCategoryView extends GetView<EditCategoryController> {
  EditCategoryView({Key? key}) : super(key: key);

  @override
  EditCategoryController controller = Get.put(EditCategoryController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit Promo Code'),
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
                Obx(() => InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        height: 300.h,
                        width: 300.h,
                        margin: const EdgeInsets.all(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                              '${controller.imgUrl.value}',
                            ))),
                      ),
                    )),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
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
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      controller.imgUrl.isNotEmpty) {
                                    controller.updateData(
                                        controller.docId.value,
                                        controller.nameController.text,
                                        controller.imgUrl.value);
                                    Get.back();
                                  }
                                },
                                title: 'Edit',
                                color: ColorManager.green),
                            SizedBox(
                              width: 20.w,
                            ),
                            PrimaryButton(
                              onPressed: () {
                                Get.back();
                              },
                              title: 'Cancel',
                              color: ColorManager.error,
                            ),
                          ],
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
