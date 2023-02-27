import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_dialog.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/global_table.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text.dart';
import 'package:home_away_dashboard/app/routes/app_pages.dart';

import '../controllers/faqs_controller.dart';

class FaqsView extends GetView<FaqsController> {
  const FaqsView({Key? key}) : super(key: key);
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
                    child: CustomSearch(hint: 'Search for FAQ'),
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
                    width: 100.w,
                    child: PrimaryButton(
                      title: "Add a new FAQ",
                      fontSize: 8,
                      onPressed: () {
                        Get.toNamed(Routes.ADD_FAQ);
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
                stream:
                    FirebaseFirestore.instance.collection('faqs').snapshots(),
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
                        label: Text("Question"),
                      ),
                      DataColumn(
                        label: Text("Answer"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                      ),
                    ],
                    rows: List.generate(
                      snapshot.data.docs.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            PrimaryText(
                              snapshot.data?.docs[index]?.data()['question'],
                              fontSize: 11.sp,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data?.docs[index]?.data()['answer'],
                              fontSize: 11.sp,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                PrimaryButton(
                                  color: ColorManager.green,
                                  title: 'Edit',
                                  fontSize: 8,
                                  onPressed: () {
                                    Get.toNamed(
                                      Routes.EDIT_FAQ,
                                      arguments: [
                                        {
                                          "docId":
                                              '${snapshot.data?.docs[index]?.id}'
                                        },
                                        {
                                          "question":
                                              '${snapshot.data?.docs[index]?.data()['question']}'
                                        },
                                        {
                                          "answer":
                                              '${snapshot.data?.docs[index]?.data()['answer']}'
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
                                        FaqsController.deleteRow(
                                          snapshot.data?.docs[index].id,
                                        );
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
