import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_away_dashboard/app/global_presentation/global_features/color_manager.dart';
import 'package:home_away_dashboard/app/modules/Categories/views/categories_view.dart';
import 'package:home_away_dashboard/app/modules/ContactMessages/views/contact_messages_view.dart';
import 'package:home_away_dashboard/app/modules/PromoCodes/views/promo_codes_view.dart';
import 'package:home_away_dashboard/app/modules/Users/views/users_view.dart';
import 'package:home_away_dashboard/app/modules/faqs/views/faqs_view.dart';
import 'package:home_away_dashboard/app/modules/notifications/views/notifications_view.dart';
import 'package:home_away_dashboard/app/modules/orders/views/orders_view.dart';
import 'package:home_away_dashboard/app/modules/packages/views/packages_view.dart';
import 'package:home_away_dashboard/app/routes/app_pages.dart';
import '../../Dashboard/views/dashboard_view.dart';
import 'package:get/get.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int active = 0;
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 9,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }
  String Title(){
    if(tabController.index == 0){
      return "Dashboard";
    }else if(tabController.index == 1){
      return "Users";
    }else if(tabController.index == 2){
      return "Orders";
    }else if(tabController.index == 3){
      return "Categories";
    }else if(tabController.index == 4){
      return "Packages";
    }else if(tabController.index == 5){
      return "Promo Codes";
    }else if(tabController.index == 6){
      return "Contact Messages";
    }else if(tabController.index == 7){
      return "Notifications";
    }else if(tabController.index == 8){
      return "FAQs";
    }else{
      return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(Title()),
      ),
      backgroundColor: ColorManager.bgColor,
      drawer:Container(
         child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'assets/images/login-form.png',
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                DrawerListTile(
                  title: 'Dashboard',
                  iconData: Icons.dashboard_outlined,
                  press: () {
                    tabController.animateTo(0);
                  },
                  selected: tabController.index == 0,
                ),
                DrawerListTile(
                  title: 'Users',
                  iconData: Icons.person_outline,
                  press: () {
                    tabController.animateTo(1);
                  },
                  selected: tabController.index == 1,
                ),
                DrawerListTile(
                  title: 'Orders',
                  iconData: Icons.shopping_cart_outlined,
                  press: () {
                    tabController.animateTo(2);
                  },
                  selected: tabController.index == 2,
                ),
                DrawerListTile(
                  title: 'Categories',
                  iconData: Icons.category_outlined,
                  press: () {
                    tabController.animateTo(3);
                  },
                  selected: tabController.index == 3,
                ),
                DrawerListTile(
                  title: 'Packages',
                  iconData: Icons.shop_2_outlined,
                  selected: tabController.index == 4,
                  press: () {
                    tabController.animateTo(4);
                  },
                ),
                DrawerListTile(
                  title: 'Promo Codes',
                  iconData: Icons.discount_outlined,
                  selected: tabController.index == 5,
                  press: () {
                    tabController.animateTo(5);
                  },
                ),
                DrawerListTile(
                  title: 'Contact Messages',
                  iconData: Icons.message_outlined,
                  selected: tabController.index == 6,
                  press: () {
                    tabController.animateTo(6);
                  },
                ),
                DrawerListTile(
                  title: 'Notifications',
                  iconData: Icons.notifications_outlined,
                  selected: tabController.index == 7,
                  press: () {
                    tabController.animateTo(7);
                  },
                ),
                DrawerListTile(
                  title: 'FAQs',
                  iconData: Icons.question_mark_outlined,
                  selected: tabController.index == 8,
                  press: () {
                    tabController.animateTo(8);
                  },
                ),
                DrawerListTile(
                  title: 'LogOut',
                  iconData:  Icons.logout,
                  selected: tabController.index > 8,
                  press: ()  async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: TabBarView(
                controller: tabController,
                children: [
                  DashboardView(),
                  const UsersView(),
                  const OrdersView(),
                  const CategoriesView(),
                  PackagesView(),
                  const PromoCodesView(),
                  const ContactMessagesView(),
                  const NotificationsView(),
                  const FaqsView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key, this.title, this.iconData, this.press, this.selected})
      : super(key: key);

  final String? title;
  final IconData? iconData;
  final VoidCallback? press;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      selected: selected!,
      horizontalTitleGap: 0.0,
      leading: Icon(
        iconData,
        color: Colors.white,
        size: 50.h,
      ),
      title: Text(
        '$title',
        style:   TextStyle(color: Colors.white54,),
      ),
    );
  }
}
