import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/modules/AddNewPackage/views/add_new_package_view.dart';

import '../../../global_presentation/global_widgets/custom_dialog.dart';
import '../../../global_presentation/global_widgets/custom_search.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../../../global_presentation/global_widgets/primary_text.dart';
import '../controllers/packages_controller.dart';

class PackagesView extends GetView<PackagesController> {
  PackagesView({Key? key}) : super(key: key);

  @override
  PackagesController controller = Get.put(PackagesController());

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
                    hint: 'Search for a package',
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
                  width: 120.w,
                  child: PrimaryButton(
                    title: "Add a new package",
                    fontSize: 9,
                    onPressed: () {
                      Get.to(AddNewPackageView());
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
                  FirebaseFirestore.instance.collection('packages').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return PrimaryTable(
                    columns: const [
                      DataColumn(
                        label: Text("Category"),
                      ),
                      DataColumn(
                        label: Text("Country"),
                      ),
                      DataColumn(
                        label: Text("Duration"),
                      ),
                      DataColumn(
                        label: Text("Price"),
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
                            controller.categoryName.isNotEmpty
                                ? PrimaryText(
                                    "${controller.categoryName[index]}",
                                    fontSize: 8,
                                    textAlign: TextAlign.start,
                                  )
                                : const CircularProgressIndicator(),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data.docs[index].data()['country'],
                              fontSize: 11,
                            ),
                          ),
                          DataCell(
                            PrimaryText(
                              snapshot.data.docs[index].data()['duration'],
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
                            Row(
                              children: [
                                PrimaryButton(
                                  color: ColorManager.green,
                                  title: 'Edit',
                                  fontSize: 8,
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                PrimaryButton(
                                  color: ColorManager.error,
                                  title: 'Delete',
                                  fontSize: 8,
                                  onPressed: () {
                                    controller.fetchCategories();
                                    controller.fetchCategoryName();
                                    showMyDialog(
                                      title: 'Alert Dialog',
                                      content:
                                          'Are you sure you want to delete this row?',
                                      actionTitle1: 'Yes',
                                      actionFunction1: () {
                                        PackagesController.deleteCategory(
                                            snapshot.data?.docs[index]?.id);
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
