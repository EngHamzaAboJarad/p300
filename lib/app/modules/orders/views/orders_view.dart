import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';
import 'package:intl/intl.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../../../global_presentation/global_widgets/primary_button.dart';
import '../../../global_presentation/global_widgets/primary_text.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: CustomSearch(
                    hint: 'Search for order',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('orders').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return PrimaryTable(
                    columns: const [
                      DataColumn(
                        label: Text("Order number"),
                      ),
                      DataColumn(
                        label: Text("Person Full Name"),
                      ),
                      DataColumn(
                        label: Text("Company Name"),
                      ),
                      DataColumn(
                        label: Text("Order Date"),
                      ),
                      DataColumn(
                        label: Text("Price"),
                      ),
                      DataColumn(
                        label: Text("Status"),
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
                              "                              ${snapshot.data.docs[index].data()['order_number']}",
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data.docs[index].data()['username'],
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data.docs[index].data()['company_name'],
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              DateFormat("dd/MM/yyyy").format(
                                  (snapshot.data.docs[index].data()['date']
                                          as Timestamp)
                                      .toDate()),
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data.docs[index]
                                  .data()['price']
                                  .toString(),
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data.docs[index].data()['status'] ==
                                      'accepted'
                                  ? "Approved"
                                  : "in progress",
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                PrimaryButton(
                                  color: ColorManager.green,
                                  title: 'Approve',
                                  fontSize: 8,
                                  onPressed: () {
                                    final CollectionReference
                                        collectionReference = FirebaseFirestore
                                            .instance
                                            .collection("orders");
                                    collectionReference
                                        .doc(snapshot.data.docs[index]['id'])
                                        .update(
                                      {"status": 'accepted'},
                                    ).whenComplete(
                                      () async {
                                        log("Completed");
                                      },
                                    ).catchError(
                                      (e) => log(e),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                PrimaryButton(
                                  color: ColorManager.error,
                                  title: 'Reject',
                                  fontSize: 8,
                                  onPressed: () {
                                    final CollectionReference
                                        collectionReference = FirebaseFirestore
                                            .instance
                                            .collection("orders");
                                    collectionReference
                                        .doc(snapshot.data.docs[index]['id'])
                                        .update(
                                      {"status": 'rejected'},
                                    ).whenComplete(
                                      () async {
                                        log("Completed");
                                      },
                                    ).catchError(
                                      (e) => log(e),
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum OrderOptions { accepted, inProgress, rejected }
