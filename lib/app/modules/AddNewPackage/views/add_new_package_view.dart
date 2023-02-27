import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text_field.dart';

import '../controllers/add_new_package_controller.dart';

class AddNewPackageView extends GetView<AddNewPackageController> {
  AddNewPackageView({Key? key}) : super(key: key);

  @override
  AddNewPackageController controller = Get.put(AddNewPackageController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Package'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Obx(
                    () {
                      return controller.category.isEmpty
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: 600.w,
                              child: Stepper(
                                currentStep: controller.cureentStep.value,
                                onStepTapped: (index) {
                                  controller.cureentStep.value = index;
                                },
                                onStepCancel: () {
                                  if (controller.cureentStep.value != 0) {
                                    controller.cureentStep.value--;
                                  }
                                },
                                onStepContinue: () {
                                  if (controller.cureentStep.value != 7) {
                                    controller.cureentStep.value++;
                                  }
                                },
                                controlsBuilder: (context, details) {
                                  return controller.cureentStep.value != 7
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10.h),
                                          child: Row(
                                            children: [
                                              PrimaryButton(
                                                  onPressed:
                                                      details.onStepContinue,
                                                  fontSize: 8,
                                                  title: 'Next'),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              PrimaryButton(
                                                  onPressed:
                                                      details.onStepCancel,
                                                  color: ColorManager.error,
                                                  fontSize: 8,
                                                  title: 'Back')
                                            ],
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            PrimaryButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                          .validate() &&
                                                      controller.imgPackageUrls
                                                          .isNotEmpty &&
                                                      controller.imgHotelUrls
                                                          .isNotEmpty &&
                                                      controller.imgServiceUrls
                                                          .isNotEmpty) {
                                                    controller
                                                        .addDailyItinerary();
                                                    controller
                                                        .addPriceDetails();
                                                    controller
                                                        .addIncludedDetails();
                                                    controller
                                                        .addExcludedDetails();

                                                    controller.addNewPackage(
                                                      controller
                                                          .countryController
                                                          .text,
                                                      controller.imgPackageUrls,
                                                      controller
                                                          .cityController.text,
                                                      controller
                                                          .durationController
                                                          .text,
                                                      double.parse(controller
                                                          .priceController
                                                          .text),
                                                      double.parse(controller
                                                          .oldPriceController
                                                          .text),
                                                      controller
                                                          .selectedCategory
                                                          .value,
                                                      controller
                                                          .airPortController
                                                          .text,
                                                      controller
                                                          .flightNumberController
                                                          .text,
                                                      controller
                                                          .flightDateController
                                                          .text,
                                                      controller
                                                          .flightTimeController
                                                          .text,
                                                      controller
                                                          .originCityController
                                                          .text,
                                                      controller
                                                          .destinationTimeController
                                                          .text,
                                                      controller
                                                          .destinationCityController
                                                          .text,
                                                      controller
                                                          .hotelNameController
                                                          .text,
                                                      controller
                                                          .hotelCityController
                                                          .text,
                                                      controller
                                                          .startDateController
                                                          .text,
                                                      controller
                                                          .endDateController
                                                          .text,
                                                      double.parse(controller
                                                          .rating!.value),
                                                      controller.imgHotelUrls,
                                                      controller.imgServiceUrls,
                                                      controller
                                                          .airportToHotelController
                                                          .text,
                                                      controller
                                                          .internallController
                                                          .text,
                                                      controller
                                                          .hotelToairportController
                                                          .text,
                                                      controller.dailyInterList,
                                                      controller
                                                          .priceDetalisList,
                                                      controller.includedList,
                                                      controller.excludedList,
                                                    );
                                                    Get.back();
                                                  }
                                                },
                                                fontSize: 8,
                                                title: 'Add Package'),
                                          ],
                                        );
                                },
                                steps: [
                                  Step(
                                      isActive:
                                          controller.cureentStep.value >= 0,
                                      title: const PrimaryText(
                                        'Package Details',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          SizedBox(
                                            height: 100.h,
                                          ),
                                          if (controller
                                                  .imgPackageUrls.isEmpty &&
                                              !controller
                                                  .isPackageImgLoding.value)
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller
                                                        .pickPackageImages();
                                                  },
                                                  child: Container(
                                                    height: 300.h,
                                                    width: 300.h,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            50),
                                                    decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: const Center(
                                                      child: Icon(Icons.camera),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                const PrimaryText(
                                                  'Please pick more than one image for package',
                                                  fontSize: 8,
                                                )
                                              ],
                                            ),
                                          if (controller
                                                  .imgPackageUrls.isEmpty &&
                                              controller
                                                  .isPackageImgLoding.value)
                                            const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          if (controller
                                                  .imgPackageUrls.isNotEmpty &&
                                              controller.isPackageImgFinish
                                                      .value ==
                                                  false)
                                            SizedBox(
                                              child: SizedBox(
                                                width: 300.w,
                                                height: 400.h,
                                                child: GridView.count(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 10.0,
                                                    mainAxisSpacing: 10.0,
                                                    shrinkWrap: true,
                                                    children: List.generate(
                                                      controller.imgPackageUrls
                                                          .length,
                                                      (index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Container(
                                                            width: 30.w,
                                                            height: 30.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                  '${controller.imgPackageUrls[index]}',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10.0),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )),
                                              ),
                                            ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Country Name',
                                                  controller: controller
                                                      .countryController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Country Name';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'City Name',
                                                  controller:
                                                      controller.cityController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter City Name';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Duration  ',
                                                  controller: controller
                                                      .durationController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Duration  ';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Price',
                                                  controller: controller
                                                      .priceController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Price';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Old Price',
                                                  controller: controller
                                                      .oldPriceController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Old Price';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                                height: 100.h,
                                                width: 250.w,
                                                child: DropdownButton<String?>(
                                                  value: controller
                                                      .selectedCategory.value,
                                                  items: controller.category
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String?>(
                                                            value: item,
                                                            child: PrimaryText(
                                                              item,
                                                              fontSize: 8,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  onChanged: (item) {
                                                    controller.selectedCategory
                                                        .value = item!;
                                                  },
                                                )),
                                          ),
                                        ],
                                      )),
                                  Step(
                                      isActive:
                                          controller.cureentStep.value >= 1,
                                      title: const PrimaryText(
                                        'Flight Details',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Airport Name',
                                                  controller: controller
                                                      .airPortController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Airport Name';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Flight Number',
                                                  controller: controller
                                                      .flightNumberController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Flight Number';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  onTap: () => controller
                                                      .chooseDate(controller
                                                          .flightDateController),
                                                  readOnly: true,
                                                  hintText: 'Flight Date',
                                                  controller: controller
                                                      .flightDateController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Flight Date';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  onTap: () => controller
                                                      .chooseTime(controller
                                                          .flightTimeController),
                                                  readOnly: true,
                                                  hintText: 'Flight Time',
                                                  controller: controller
                                                      .flightTimeController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Flight Time';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Origin City',
                                                  controller: controller
                                                      .originCityController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Origin City Name';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  onTap: () => controller
                                                      .chooseTime(controller
                                                          .destinationTimeController),
                                                  readOnly: true,
                                                  hintText: 'Destination Time',
                                                  controller: controller
                                                      .destinationTimeController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Destination Time';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Destination City',
                                                  controller: controller
                                                      .destinationCityController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Destination City Name';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Step(
                                      isActive: controller.cureentStep >= 2,
                                      title: const PrimaryText(
                                        'Hotel Details',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Hotel Name',
                                                  controller: controller
                                                      .hotelNameController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Hotel Name';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Hotel City',
                                                  controller: controller
                                                      .hotelCityController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Hotel City';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  onTap: () => controller
                                                      .chooseDate(controller
                                                          .startDateController),
                                                  readOnly: true,
                                                  hintText: 'Start Date',
                                                  controller: controller
                                                      .startDateController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Start Date';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  onTap: () => controller
                                                      .chooseDate(controller
                                                          .endDateController),
                                                  readOnly: true,
                                                  hintText: 'End Date',
                                                  controller: controller
                                                      .endDateController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter End Date';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                                height: 100.h,
                                                width: 250.w,
                                                child: RatingBar.builder(
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 4.0..w),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rate) {
                                                    controller.rating!.value =
                                                        rate.toString();
                                                  },
                                                )),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (controller
                                                      .imgHotelUrls.isEmpty &&
                                                  !controller
                                                      .isHotelImgLoading.value)
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .pickHotelImages();
                                                      },
                                                      child: Container(
                                                        height: 300.h,
                                                        width: 300.h,
                                                        margin: const EdgeInsets
                                                            .all(50),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorManager
                                                              .secondaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                              Icons.camera),
                                                        ),
                                                      ),
                                                    ),
                                                    const PrimaryText(
                                                      'Please pick more than one image for hotles',
                                                      fontSize: 8,
                                                    )
                                                  ],
                                                ),
                                              if (controller
                                                      .imgHotelUrls.isEmpty &&
                                                  controller
                                                      .isHotelImgLoading.value)
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              if (controller.imgHotelUrls
                                                      .isNotEmpty &&
                                                  controller.isHotelImgFinish
                                                          .value ==
                                                      false)
                                                SizedBox(
                                                  child: SizedBox(
                                                    width: 300.w,
                                                    height: 400.h,
                                                    child: GridView.count(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 10.0,
                                                        shrinkWrap: true,
                                                        children: List.generate(
                                                          controller
                                                              .imgHotelUrls
                                                              .length,
                                                          (index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Container(
                                                                width: 30.w,
                                                                height: 30.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      '${controller.imgHotelUrls[index]}',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        10.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        )),
                                                  ),
                                                ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              if (controller
                                                      .imgServiceUrls.isEmpty &&
                                                  !controller
                                                      .isServiceImgLoding.value)
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .pickServiceImages();
                                                      },
                                                      child: Container(
                                                        height: 300.h,
                                                        width: 300.h,
                                                        margin: const EdgeInsets
                                                            .all(50),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorManager
                                                              .secondaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                              Icons.camera),
                                                        ),
                                                      ),
                                                    ),
                                                    const PrimaryText(
                                                      'Please pick more than one image for services',
                                                      fontSize: 8,
                                                    )
                                                  ],
                                                ),
                                              if (controller
                                                      .imgServiceUrls.isEmpty &&
                                                  controller
                                                      .isServiceImgLoding.value)
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              if (controller.imgServiceUrls
                                                      .isNotEmpty &&
                                                  controller.isServiceImgFinish
                                                          .value ==
                                                      false)
                                                SizedBox(
                                                  child: SizedBox(
                                                    width: 300.w,
                                                    height: 400.h,
                                                    child: GridView.count(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10.0,
                                                        mainAxisSpacing: 10.0,
                                                        shrinkWrap: true,
                                                        children: List.generate(
                                                          controller
                                                              .imgServiceUrls
                                                              .length,
                                                          (index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      10.0),
                                                              child: Container(
                                                                width: 30.w,
                                                                height: 30.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        NetworkImage(
                                                                      '${controller.imgServiceUrls[index]}',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        10.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        )),
                                                  ),
                                                ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Step(
                                      isActive: controller.cureentStep >= 3,
                                      title: const PrimaryText(
                                        'Transportation Details',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText:
                                                      'Airport to hotel Way',
                                                  controller: controller
                                                      .airportToHotelController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Airport to hotel Way';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText: 'Internal Way',
                                                  controller: controller
                                                      .internallController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Internal Way';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 35.h),
                                            child: SizedBox(
                                              height: 100.h,
                                              width: 250.w,
                                              child: PrimaryTextField(
                                                  hintText:
                                                      'Hotel to airport Way',
                                                  controller: controller
                                                      .hotelToairportController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Enter Hotel to airport Way';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Step(
                                      isActive: controller.cureentStep >= 4,
                                      title: const PrimaryText(
                                        'Daily itinerary',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          ListView.separated(
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.dayController.length,
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                color:
                                                    ColorManager.secondaryColor,
                                                thickness: 1,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        25.w,
                                                                    vertical:
                                                                        35.h),
                                                            child: SizedBox(
                                                              height: 100.h,
                                                              width: 250.w,
                                                              child:
                                                                  PrimaryTextField(
                                                                      hintText:
                                                                          'Day Name',
                                                                      controller:
                                                                          controller.dayController[
                                                                              index],
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Enter Day Name';
                                                                        }
                                                                        return null;
                                                                      }),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        25.w,
                                                                    vertical:
                                                                        35.h),
                                                            child: SizedBox(
                                                              height: 100.h,
                                                              width: 250.w,
                                                              child:
                                                                  PrimaryTextField(
                                                                      hintText:
                                                                          'Day Title',
                                                                      controller:
                                                                          controller.titleController[
                                                                              index],
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Enter Day Title';
                                                                        }
                                                                        return null;
                                                                      }),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        25.w,
                                                                    vertical:
                                                                        35.h),
                                                            child: SizedBox(
                                                              height: 200.h,
                                                              width: 250.w,
                                                              child:
                                                                  PrimaryTextField(
                                                                      multiLines:
                                                                          true,
                                                                      hintText:
                                                                          'Day Details',
                                                                      controller:
                                                                          controller.detailsController[
                                                                              index],
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Enter Day Title';
                                                                        }
                                                                        return null;
                                                                      }),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      controller.dayController
                                                                  .length >
                                                              1
                                                          ? InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .dayController
                                                                    .removeAt(
                                                                        index);
                                                                controller
                                                                    .titleController
                                                                    .removeAt(
                                                                        index);

                                                                controller
                                                                    .detailsController
                                                                    .removeAt(
                                                                        index);
                                                              },
                                                              child: Container(
                                                                height: 100.h,
                                                                width: 100.h,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(50),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ColorManager
                                                                      .secondaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(Icons
                                                                      .delete),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () => controller
                                                    .createDailyItineraryController(),
                                                child: Container(
                                                  height: 100.h,
                                                  width: 100.h,
                                                  margin:
                                                      const EdgeInsets.all(50),
                                                  decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Step(
                                      isActive: controller.cureentStep >= 5,
                                      title: const PrimaryText(
                                        'Price Details',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .titlePriceController.length,
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                color:
                                                    ColorManager.secondaryColor,
                                                thickness: 1,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    25.w,
                                                                vertical: 35.h),
                                                        child: SizedBox(
                                                          height: 100.h,
                                                          width: 250.w,
                                                          child:
                                                              PrimaryTextField(
                                                                  hintText:
                                                                      'Title',
                                                                  controller:
                                                                      controller
                                                                              .titlePriceController[
                                                                          index],
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Enter Title';
                                                                    }
                                                                    return null;
                                                                  }),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    25.w,
                                                                vertical: 35.h),
                                                        child: SizedBox(
                                                          height: 100.h,
                                                          width: 250.w,
                                                          child:
                                                              PrimaryTextField(
                                                                  hintText:
                                                                      'Price',
                                                                  controller:
                                                                      controller
                                                                              .priceDetailsController[
                                                                          index],
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Enter Price';
                                                                    }
                                                                    return null;
                                                                  }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  controller.titlePriceController
                                                              .length >
                                                          1
                                                      ? InkWell(
                                                          onTap: () {
                                                            controller
                                                                .titlePriceController
                                                                .removeAt(
                                                                    index);

                                                            controller
                                                                .priceDetailsController
                                                                .removeAt(
                                                                    index);
                                                          },
                                                          child: Container(
                                                            height: 100.h,
                                                            width: 100.h,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(50),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorManager
                                                                  .secondaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                  Icons.delete),
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () => controller
                                                    .createPriceDetailsController(),
                                                child: Container(
                                                  height: 100.h,
                                                  width: 100.h,
                                                  margin:
                                                      const EdgeInsets.all(50),
                                                  decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Step(
                                      isActive: controller.cureentStep >= 6,
                                      title: const PrimaryText(
                                        'Included Details',
                                        fontSize: 10,
                                      ),
                                      content: Column(
                                        children: [
                                          ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .includedController.length,
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                color:
                                                    ColorManager.secondaryColor,
                                                thickness: 1,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    25.w,
                                                                vertical: 35.h),
                                                        child: SizedBox(
                                                          height: 100.h,
                                                          width: 250.w,
                                                          child:
                                                              PrimaryTextField(
                                                                  hintText:
                                                                      'Title',
                                                                  controller:
                                                                      controller
                                                                              .includedController[
                                                                          index],
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Enter Title';
                                                                    }
                                                                    return null;
                                                                  }),
                                                        ),
                                                      ),
                                                      controller.includedController
                                                                  .length >
                                                              1
                                                          ? InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .includedController
                                                                    .removeAt(
                                                                        index);
                                                              },
                                                              child: Container(
                                                                height: 100.h,
                                                                width: 100.h,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(50),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ColorManager
                                                                      .secondaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(Icons
                                                                      .delete),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                      .createIncludedController();
                                                },
                                                child: Container(
                                                  height: 100.h,
                                                  width: 100.h,
                                                  margin:
                                                      const EdgeInsets.all(50),
                                                  decoration: BoxDecoration(
                                                    color: ColorManager
                                                        .secondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(Icons.add),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Step(
                                    isActive: controller.cureentStep >= 7,
                                    title: const PrimaryText(
                                      'Excluded Details',
                                      fontSize: 10,
                                    ),
                                    content: Column(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .excludedController.length,
                                          separatorBuilder: (context, index) {
                                            return Divider(
                                              color:
                                                  ColorManager.secondaryColor,
                                              thickness: 1,
                                            );
                                          },
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.w,
                                                              vertical: 35.h),
                                                      child: SizedBox(
                                                        height: 100.h,
                                                        width: 250.w,
                                                        child: PrimaryTextField(
                                                            hintText: 'Title',
                                                            controller: controller
                                                                    .excludedController[
                                                                index],
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Enter Title';
                                                              }
                                                              return null;
                                                            }),
                                                      ),
                                                    ),
                                                    controller.excludedController
                                                                .length >
                                                            1
                                                        ? InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .excludedController
                                                                  .removeAt(
                                                                      index);
                                                            },
                                                            child: Container(
                                                              height: 100.h,
                                                              width: 100.h,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(50),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorManager
                                                                    .secondaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(Icons
                                                                    .delete),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .createExcludedController();
                                              },
                                              child: Container(
                                                height: 100.h,
                                                width: 100.h,
                                                margin:
                                                    const EdgeInsets.all(50),
                                                decoration: BoxDecoration(
                                                  color: ColorManager
                                                      .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Center(
                                                  child: Icon(Icons.add),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
