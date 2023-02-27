// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';
import 'package:home_away_dashboard/app/modules/home/views/home_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.bgColor,
        child: Center(
          child: SizedBox(
            height: Get.height * 0.65,
            width: Get.height * 0.65,
            child: Card(
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/login-image.jpg',
                        height: Get.height * 0.5,
                        width: Get.width * 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 20.h),
                      color: ColorManager.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          Image.asset(
                            'assets/images/login-form.png',
                            height: 200.h,
                            width: 200.w,
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Email',
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.white))),
                                  TextFormField(
                                    controller: controller.emailController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter email address';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      errorStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.width * 0.006),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        size: Get.width * 0.01,
                                        color: Colors.white,
                                      ),
                                    ),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8.sp),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Password',
                                      style: TextStyle(
                                          fontSize: 8.sp, color: Colors.white),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: controller.passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      errorStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.width * 0.006),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        size: Get.width * 0.01,
                                        color: Colors.white,
                                      ),
                                    ),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8.sp),
                                  ),
                                  SizedBox(
                                    height: 100.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    child: SizedBox(
                                      width: Get.width,
                                      height: 60.h,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        color: Colors.white,
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            controller
                                                .handleSignInEmail(
                                                    controller
                                                        .emailController.text,
                                                    controller
                                                        .passwordController
                                                        .text)
                                                .then(
                                              (User user) {
                                                Get.offAll(const HomeView());
                                                Get.to(const HomeView());
                                              },
                                            ).catchError(
                                              (e) => Get.snackbar(
                                                "Error",
                                                e.toString(),
                                                icon: const Icon(Icons.error,
                                                    color: Colors.white),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor: Colors.red,
                                                borderRadius: 20,
                                                margin:
                                                    const EdgeInsets.all(15),
                                                colorText: Colors.white,
                                                duration:
                                                    const Duration(seconds: 4),
                                                isDismissible: true,
                                                forwardAnimationCurve:
                                                    Curves.easeOutBack,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          'LOG IN',
                                          style: TextStyle(
                                              fontSize: 6.sp,
                                              color: ColorManager.primary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
