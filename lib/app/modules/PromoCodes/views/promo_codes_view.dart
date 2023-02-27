import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_dialog.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';
import 'package:home_away_dashboard/app/modules/AddPromoCode/views/add_promo_code_view.dart';
import 'package:home_away_dashboard/app/modules/EditPromoCode/views/edit_promo_code_view.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../../../global_presentation/global_widgets/primary_button.dart';
import '../../../global_presentation/global_widgets/primary_text.dart';

import '../controllers/promo_codes_controller.dart';

class PromoCodesView extends GetView<PromoCodesController> {
  const PromoCodesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: CustomSearch(
                      hint: 'Search for promo code',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 90.h,
                    //width: 80.w,
                    child: PrimaryButton(
                      title: "Add Promo Code",
                      fontSize: 8,
                      onPressed: () {
                        Get.to(AddPromoCodeView());
                      },
                      color: ColorManager.green,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('promo_code')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  }

                  return PrimaryTable(
                    columns: const [
                      DataColumn(
                        label: Text("Key"),
                      ),
                      DataColumn(
                        label: Text("Percentage"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                      ),
                    ],
                    rows: List.generate(
                      snapshot.data.docs.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(PrimaryText(
                            snapshot.data?.docs[index]?.data()['key'],
                            fontSize: 11,
                          )),
                          DataCell(PrimaryText(
                            "${snapshot.data?.docs[index]?.data()['percentage']}% ",
                            fontSize: 11,
                          )),
                          DataCell(
                            Row(
                              children: [
                                PrimaryButton(
                                  color: ColorManager.green,
                                  title: 'Edit',
                                  fontSize: 8,
                                  onPressed: () {
                                    Get.to(
                                      () => EditPromoCodeView(),
                                      arguments: [
                                        {
                                          "docId":
                                              '${snapshot.data?.docs[index]?.id}'
                                        },
                                        {
                                          "key":
                                              '${snapshot.data?.docs[index]?.data()['key']}'
                                        },
                                        {
                                          "percentage":
                                              '${snapshot.data?.docs[index]?.data()['percentage']}'
                                        }
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                PrimaryButton(
                                  color: ColorManager.error,
                                  title: 'Delete',
                                  fontSize: 8,
                                  onPressed: () {
                                    showMyDialog(
                                      title: 'Alert Dialog',
                                      content:
                                          'Are you sure you want to delete this row?',
                                      actionTitle1: 'Yes',
                                      actionFunction1: () {
                                        PromoCodesController.deleteData(
                                            snapshot.data?.docs[index].id);
                                        Get.back();
                                      },
                                      actionTitle2: 'No',
                                      actionFunction2: () => Get.back(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
