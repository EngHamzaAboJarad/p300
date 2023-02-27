import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';

import '../controllers/add_promo_code_controller.dart';

class AddPromoCodeView extends GetView<AddPromoCodeController> {
  AddPromoCodeView({Key? key}) : super(key: key);

  @override
  AddPromoCodeController controller = Get.put(AddPromoCodeController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Promo Code'),
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
                      hintText: 'Discount Percentage',
                      controller: controller.percentController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Discount Percentage';
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
                                controller.addNewPromoCode(
                                    controller.keyController.text,
                                    controller.percentController.text);
                                Get.back();
                                controller.keyController.clear();
                                controller.percentController.clear();
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
