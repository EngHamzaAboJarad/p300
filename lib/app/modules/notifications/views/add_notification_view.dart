import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';
import 'package:home_away_dashboard/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNotificationView extends GetView<NotificationsController> {
  AddNotificationView({Key? key}) : super(key: key);

  @override
  final controller =
      Get.put<NotificationsController>(NotificationsController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Notification'),
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
                    height: 200.h,
                    width: 300.w,
                    child: PrimaryTextField(
                      multiLines: true,
                      hintText: 'Enter your notification here',
                      controller: controller.textController,
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
                                controller.addNewNotification(
                                  controller.textController.text,
                                );
                                Get.back();
                                controller.textController.clear();
                              }
                            },
                            title: 'Add',
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
