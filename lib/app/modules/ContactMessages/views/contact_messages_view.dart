import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../../../global_presentation/global_widgets/primary_button.dart';
import '../../../global_presentation/global_widgets/primary_text.dart';

import '../controllers/contact_messages_controller.dart';

class ContactMessagesView extends GetView<ContactMessagesController> {
  const ContactMessagesView({Key? key}) : super(key: key);

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
                    hint: 'Search for a specific message',
                  )),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('contact-messages')
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
                          label: Text('Email'),
                        ),
                        DataColumn(
                          label: Text("Phone No."),
                        ),
                        DataColumn(label: Text('Message')),
                        DataColumn(
                          label: Text("Action"),
                        ),
                      ],
                      rows: List.generate(
                          snapshot.data.docs.length,
                          (index) => DataRow(cells: [
                                DataCell(PrimaryText(
                                  snapshot.data?.docs[index]?.data()['email'],
                                  fontSize: 11,
                                )),
                                DataCell(PrimaryText(
                                  snapshot.data?.docs[index]?.data()['Mobile'],
                                  fontSize: 11,
                                )),
                                DataCell(InkWell(
                                  onTap: () => Get.defaultDialog(
                                    title: "Message",
                                    middleText:
                                        '${snapshot.data?.docs[index]?.data()['message']}',
                                    backgroundColor: ColorManager.primary,
                                    titleStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),
                                    middleTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 11.sp),
                                  ),
                                  child: PrimaryText(
                                    snapshot.data?.docs[index]
                                        ?.data()['message'],
                                    fontSize: 11,
                                    maxLines: 1,
                                  ),
                                )),
                                DataCell(Row(
                                  children: [
                                    PrimaryButton(
                                      color: ColorManager.green,
                                      title: 'Reply',
                                      fontSize: 8,
                                      onPressed: () {},
                                    ),
                                  ],
                                )),
                              ])),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
