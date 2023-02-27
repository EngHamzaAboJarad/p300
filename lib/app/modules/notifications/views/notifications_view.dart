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
import 'package:home_away_dashboard/app/modules/notifications/views/add_notification_view.dart';
import 'package:intl/intl.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

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
                      hint: 'Search for notification',
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
                    width: 140.w,
                    child: PrimaryButton(
                      title: "Add a new notification",
                      fontSize: 8.sp,
                      onPressed: () {
                        Get.to(AddNotificationView());
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
                    .collection('notifications')
                    .orderBy('date', descending: true)
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
                        label: Text("Notification"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                      ),
                    ],
                    rows: List.generate(snapshot.data.docs.length, (index) {
                      final timestamp =
                          snapshot.data?.docs[index]?.data()['date'];
                      final dateTime =
                          DateTime.parse(timestamp.toDate().toString());

                      return DataRow(
                        cells: [
                          DataCell(
                            PrimaryText(
                              snapshot.data?.docs[index]?.data()['text'],
                              fontSize: 11.sp,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              "${DateFormat.yMMMd().format(dateTime)} | ${DateFormat.jm().format(dateTime)}",
                              fontSize: 11.sp,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
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
                                    NotificationsController.deleteRow(
                                      snapshot.data?.docs[index].id,
                                    );
                                    Get.back();
                                  },
                                  actionTitle2: 'No',
                                  actionFunction2: () => Get.back(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
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
