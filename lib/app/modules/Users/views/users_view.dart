import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_button.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SafeArea(
        child: Padding(
          padding:   EdgeInsets.symmetric(horizontal: 8.h),

          child: Column(
            children: [
              Row(
                children: [
                   const Expanded(
                    child: CustomSearch(
                      hint: 'Search for user',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 30.h,
              ),
               // StreamBuilder<QuerySnapshot>(
               //    stream: FirebaseFirestore.instance
               //        .collection('users')
               //        .snapshots(),
               //    builder: (context, AsyncSnapshot snapshot) {
               //      if (snapshot.connectionState == ConnectionState.waiting) {
               //        return const Center(child: CircularProgressIndicator());
               //      } else if (snapshot.hasError) {
               //        return const Center(
               //          child: Icon(Icons.error),
               //        );
               //      }
               //
               //      return
               //        PrimaryTable(
               //        columns: const [
               //          DataColumn(
               //            label: Text("Image"),
               //          ),
               //          DataColumn(
               //            label: Text("Username"),
               //          ),
               //          DataColumn(
               //            label: Text("Email"),
               //          ),
               //          DataColumn(
               //            label: Text("Phone No."),
               //          ),
               //          DataColumn(
               //            label: Text("Action"),
               //          ),
               //        ],
               //        rows: List.generate(
               //          snapshot.data.docs.length,
               //          (index) => DataRow(
               //            cells: [
               //              DataCell(
               //                SizedBox(
               //                  child: CircleAvatar(
               //                    backgroundColor: Colors.transparent,
               //                    backgroundImage: CachedNetworkImageProvider(
               //                      snapshot.data?.docs[index]
               //                                      ?.data()['image_path'] ==
               //                                  '' ||
               //                              snapshot.data?.docs[index]
               //                                      ?.data()['image_path'] ==
               //                                  null
               //                          ? 'https://i.pinimg.com/236x/2a/2e/7f/2a2e7f0f60b750dfb36c15c268d0118d.jpg'
               //                          : snapshot.data?.docs[index]
               //                              ?.data()['image_path'],
               //                    ),
               //                    radius: 20,
               //                  ),
               //                ),
               //              ),
               //              DataCell(
               //                PrimaryText(
               //                  snapshot.data?.docs[index]?.data()['name'],
               //                  fontSize: 11,
               //                ),
               //              ),
               //              DataCell(
               //                PrimaryText(
               //                  snapshot.data?.docs[index]?.data()['email'],
               //                  fontSize: 11,
               //                ),
               //              ),
               //              DataCell(
               //                PrimaryText(
               //                  snapshot.data?.docs[index]?.data()['mobileNo'],
               //                  fontSize: 11,
               //                ),
               //              ),
               //              DataCell(
               //                Row(
               //                  children: [
               //                    PrimaryButton(
               //                      color: ColorManager.primary,
               //                      title: 'Show',
               //                      fontSize: 8,
               //                      onPressed: () {},
               //                    ),
               //                  ],
               //                ),
               //              ),
               //            ],
               //          ),
               //        ),
               //      );
               //    }),
              Expanded(
                child: PrimaryTable(
                 columns: const [
                   DataColumn(
                     label: Text("Image"),
                   ),
                   DataColumn(
                     label: Text("Username"),
                   ),
                   DataColumn(
                     label: Text("Email"),
                   ),
                   DataColumn(
                     label: Text("Phone No."),
                   ),
                   DataColumn(
                     label: Text("Action"),
                   ),
                 ],
                 rows: List.generate(
                   demoUsers.length,
                       (index) => DataRow(
                     cells: [
                       DataCell(
                         CircleAvatar(
                           backgroundColor: Colors.transparent,
                           backgroundImage: CachedNetworkImageProvider(
                             demoUsers[index].imagePath ==
                                 '' ||
                                 demoUsers[index].imagePath ==
                                     null
                                 ? 'https://i.pinimg.com/236x/2a/2e/7f/2a2e7f0f60b750dfb36c15c268d0118d.jpg'
                                 :demoUsers[index].imagePath!,
                           ),
                           radius: 20,
                         ),
                       ),
                       DataCell(
                         PrimaryText(
                           demoUsers[index].name!,
                           fontSize: 11,
                         ),
                       ),
                       DataCell(
                         PrimaryText(
                           demoUsers[index].email!,
                           fontSize: 11,
                         ),
                       ),
                       DataCell(
                         PrimaryText(
                           demoUsers[index].mobileNo!,
                           fontSize: 11,
                         ),
                       ),
                       DataCell(
                         PrimaryButton(
                           color: ColorManager.primary,
                           title: 'Show',
                           fontSize: 20,
                           onPressed: () {},
                         ),
                       ),
                     ],
                   ),
                 ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DataRow recentFileDataRow(UserModel fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(fileInfo.name!),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.email!)),
        DataCell(
          Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                padding: EdgeInsets.all(15.h),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                    color: ColorManager.green,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Icon(
                    Icons.edit,
                    size: 30.h,
                  ),
                ),
              ),
              Container(
                height: 50.h,
                width: 50.w,
                padding: EdgeInsets.all(15.h),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: ColorManager.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    Icons.delete,
                    size: 30.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserModel {
  final String? name, email, mobileNo, imagePath;

  UserModel({
    this.name,
    this.email,
    this.mobileNo,
    this.imagePath,
  });
}

List<UserModel> demoUsers = [
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
  UserModel(
    name: "mk@gmail.com",
    email: "Mahmoud Ibrahim",
    mobileNo: "05999999999999",
    imagePath:
        "https://images.unsplash.com/photo-1650389176833-8dbb23d0d8f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80",
  ),
];
