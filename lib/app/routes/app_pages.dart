import 'package:get/get.dart';

import '../modules/AddNewCategory/bindings/add_new_category_binding.dart';
import '../modules/AddNewCategory/views/add_new_category_view.dart';
import '../modules/AddNewPackage/bindings/add_new_package_binding.dart';
import '../modules/AddNewPackage/views/add_new_package_view.dart';
import '../modules/AddPromoCode/bindings/add_promo_code_binding.dart';
import '../modules/AddPromoCode/views/add_promo_code_view.dart';
import '../modules/Categories/AddCategory/bindings/categories_add_category_binding.dart';
import '../modules/Categories/AddCategory/views/add_category_view.dart';
import '../modules/Categories/bindings/categories_binding.dart';
import '../modules/Categories/views/categories_view.dart';
import '../modules/ContactMessages/bindings/contact_messages_binding.dart';
import '../modules/ContactMessages/views/contact_messages_view.dart';
import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/EditCategory/bindings/edit_category_binding.dart';
import '../modules/EditCategory/views/edit_category_view.dart';
import '../modules/EditPromoCode/bindings/edit_promo_code_binding.dart';
import '../modules/EditPromoCode/views/edit_promo_code_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/PromoCodes/bindings/promo_codes_binding.dart';
import '../modules/PromoCodes/views/promo_codes_view.dart';
import '../modules/Users/bindings/users_binding.dart';
import '../modules/Users/views/users_view.dart';
import '../modules/add_faq/bindings/add_faq_binding.dart';
import '../modules/add_faq/views/add_faq_view.dart';
import '../modules/edit_faq/bindings/edit_faq_binding.dart';
import '../modules/edit_faq/views/edit_faq_view.dart';
import '../modules/faqs/bindings/faqs_binding.dart';
import '../modules/faqs/views/faqs_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/packages/bindings/packages_binding.dart';
import '../modules/packages/views/packages_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES_ADD_CATEGORY,
      page: () => const AddCategoryView(),
      binding: CategoriesAddCategoryBinding(),
    ),
    GetPage(
      name: _Paths.PROMO_CODES,
      page: () => const PromoCodesView(),
      binding: PromoCodesBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_MESSAGES,
      page: () => const ContactMessagesView(),
      binding: ContactMessagesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROMO_CODE,
      page: () => AddPromoCodeView(),
      binding: AddPromoCodeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROMO_CODE,
      page: () => EditPromoCodeView(),
      binding: EditPromoCodeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_CATEGORY,
      page: () => AddNewCategoryView(),
      binding: AddNewCategoryBinding(),
    ),
    GetPage(
      name: _Paths.FAQS,
      page: () => const FaqsView(),
      binding: FaqsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGES,
      page: () => PackagesView(),
      binding: PackagesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_FAQ,
      page: () => AddFaqView(),
      binding: AddFaqBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_FAQ,
      page: () => EditFaqView(),
      binding: EditFaqBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_CATEGORY,
      page: () => EditCategoryView(),
      binding: EditCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_PACKAGE,
      page: () => AddNewPackageView(),
      binding: AddNewPackageBinding(),
    ),
  ];
}
