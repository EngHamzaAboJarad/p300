import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../controllers/edit_promo_code_controller.dart';

class EditPromoCodeView extends GetView<EditPromoCodeController> {
  EditPromoCodeView({Key? key}) : super(key: key);

  @override
  EditPromoCodeController controller = Get.put(EditPromoCodeController());
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: SizedBox(
                    height: 100.h,
                    width: 250.w,
                    child: PrimaryTextField(
                        hintText: 'Coupon Key',
                        controller: controller.keyController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Coupon Key';
                          } else if (value.length != 5) {
                            return 'Coupon Key Must Be 5 Characters';
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
                    child: PrimaryTextField(
                        hintText: 'Discount Percentage',
                        controller: controller.percentController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Discount Percentage';
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
                                  if (_formKey.currentState!.validate()) {
                                    controller.updateData(
                                        controller.docId.value,
                                        controller.keyController.text,
                                        controller.percentController.text);
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
