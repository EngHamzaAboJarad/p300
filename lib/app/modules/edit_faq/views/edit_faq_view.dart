import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';
import 'package:home_away_dashboard/app/modules/edit_faq/controllers/edit_faq_controller.dart';

class EditFaqView extends GetView<EditFaqController> {
  EditFaqView({Key? key}) : super(key: key);

  @override
  final controller = Get.put<EditFaqController>(EditFaqController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Edit FAQ'),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: SizedBox(
                    height: 100.h,
                    width: 250.w,
                    child: PrimaryTextField(
                      hintText: 'Your question',
                      controller: controller.questionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Fill field';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: SizedBox(
                    height: 100.h,
                    width: 250.w,
                    child: PrimaryTextField(
                      hintText: 'The answer',
                      controller: controller.answerController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Fill filed';
                        }
                        return null;
                      },
                    ),
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
                                if (_formKey.currentState!.validate()) {
                                  controller.updateFaqData(
                                    controller.docId.value,
                                    controller.questionController.text,
                                    controller.answerController.text,
                                  );
                                  Get.back();
                                }
                              },
                              title: 'Update',
                              color: ColorManager.green,
                            ),
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
