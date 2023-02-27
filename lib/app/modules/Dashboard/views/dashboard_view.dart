import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/custom_search.dart';
import 'package:home_away_dashboard/app/global_presentation/global_widgets/primary_text.dart';
import 'package:home_away_dashboard/app/modules/Users/views/users_view.dart';

import '../../../global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_widgets/global_table.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  @override
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 8.h),
        child: Column(
          children: [
            Row(
              children: [
                 const Expanded(
                  child: CustomSearch(
                    hint: 'Search for anything',
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 150.h, left: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 170.w,
                     decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorManager.secondaryColor),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.shopping_cart_outlined),
                          PrimaryText(
                            'Total Orders',
                            fontSize: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Container(
                    width: 180.w,
                     decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorManager.secondaryColor),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.category_outlined),
                          PrimaryText(
                            'Total Categories',
                            fontSize: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Container(
                    width: 180.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorManager.secondaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.shop_2_outlined),
                          PrimaryText(
                            'Total Packages',
                            fontSize: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100.h, left: 70.w, right: 70.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.secondaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: const PrimaryText(
                        'Last Users',
                        textAlign: TextAlign.start,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text("Image",style: TextStyle(fontSize: 10),),
                     Text("Username",style: TextStyle(fontSize: 10),),
                     Text("Email",style: TextStyle(fontSize: 10),),
                     Text("Phone No.",style: TextStyle(fontSize: 10),),
                   ],),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }else if(snapshot.hasData && snapshot.data.docs.isNotEmpty){
                        log('message=>${snapshot.data.docs}');
                       return Container(
                         width: double.infinity,
                         height: 400.h,
                         child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder:(context, index) =>
                            Padding(
                              padding:   EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: CachedNetworkImageProvider(
                                        snapshot.data?.docs[index]
                                            ?.get('image_path') ==
                                            '' ||
                                            snapshot.data?.docs[index]
                                                ?.get('image_path')==
                                                null
                                            ? 'https://i.pinimg.com/236x/2a/2e/7f/2a2e7f0f60b750dfb36c15c268d0118d.jpg'
                                            : snapshot.data?.docs[index]
                                            ?.get('image_path'),
                                      ),
                                      radius: 10,
                                    ),
                                  ),
                                  Text(snapshot.data.docs[index].get('name'),style: TextStyle(fontSize: 10),),
                                  Text(snapshot.data.docs[index]?.get('email'),style: TextStyle(fontSize: 10),),
                                  Text(snapshot.data.docs[index].get('mobileNo'),style: TextStyle(fontSize: 10),),
                                ],),
                            )
                          ,),
                       );
                      }else{
                        return Container();
                      }
                      },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const UsersView());
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.secondaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: const PrimaryText(
                          'Show More',
                          textAlign: TextAlign.start,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
