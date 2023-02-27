import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';
import 'package:home_away_dashboard/app/modules/add_faq/controllers/add_faq_controller.dart';

class AddFaqView extends GetView {
  AddFaqView({Key? key}) : super(key: key);

  @override
  final controller = Get.put<AddFaqController>(AddFaqController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add FAQ'),
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
                      hintText: 'Enter your question here',
                      controller: controller.questionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field';
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
                      hintText: 'Enter your answer here',
                      controller: controller.answerController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                    ),
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
                              if (_formKey.currentState!.validate()) {
                                controller.addNewFaq(
                                    controller.questionController.text,
                                    controller.answerController.text);
                                Get.back();
                                controller.questionController.clear();
                                controller.questionController.clear();
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
