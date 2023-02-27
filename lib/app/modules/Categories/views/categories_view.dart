import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_dialog.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';
import 'package:home_away_dashboard/app/modules/AddNewCategory/views/add_new_category_view.dart';
import 'package:home_away_dashboard/app/modules/EditCategory/views/edit_category_view.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../../../global_presentation/global_widgets/primary_button.dart';
import '../../../global_presentation/global_widgets/primary_text.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);

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
                  hint: 'Search for a specific category',
                )),
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
                  width: 90.w,
                  child: PrimaryButton(
                    title: "Add Category",
                    fontSize: 9,
                    onPressed: () {
                      Get.to(AddNewCategoryView());
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
                  .collection('categories')
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
                      label: Text("Image"),
                    ),
                    DataColumn(
                      label: Text("Name"),
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
                          SizedBox(
                            height: 90.h,
                            width: 40.w,
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data.docs[index]
                                  .data()['image_path'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          PrimaryText(
                            snapshot.data?.docs[index].data()['name'],
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
                                onPressed: () {
                                  Get.to(() => EditCategoryView(), arguments: [
                                    {
                                      "docId":
                                          '${snapshot.data?.docs[index]?.id}'
                                    },
                                    {
                                      "name":
                                          '${snapshot.data?.docs[index]?.data()['name']}'
                                    },
                                    {
                                      "image_path":
                                          '${snapshot.data?.docs[index]?.data()['image_path']}'
                                    }
                                  ]);
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
                                      CategoriesController.deleteCategory(
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
              },
            )
          ],
        ),
      ),
    );
  }
}
