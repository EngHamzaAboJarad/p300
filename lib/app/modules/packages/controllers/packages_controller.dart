import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PackagesController extends GetxController {
  //TODO: Implement PackagesController
  var category = [];
  var categoryName = [];

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchCategoryName();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  static Future<void> deleteCategory(String? docId) async {
    await FirebaseFirestore.instance.collection('packages').doc(docId).delete();
  }

  Future<void> fetchCategories() async {
    category.clear();
    await FirebaseFirestore.instance
        .collection("packages")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((categorties) {
        category.add(categorties.data()['category_id']);
      });
    });
    print('${category}xxxx');
    update();
  }

  Future<void> fetchCategoryName() async {
    categoryName.clear();

    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((querySnapshot) {
      for (var item2 in querySnapshot.docs) {
        for (var item1 in category) {
          if (item1 == item2.reference.id) {
            categoryName.add(item2.data()['name']);
          }
        }
      }

      print('${categoryName}xx');
      update();
    });
  }
}
