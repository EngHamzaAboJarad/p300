import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNewPackageController extends GetxController {
  //Package Controller
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController durationController;
  late TextEditingController priceController;
  late TextEditingController oldPriceController;
  //Flight Controller
  late TextEditingController airPortController;
  late TextEditingController flightNumberController;
  late TextEditingController flightDateController;
  late TextEditingController flightTimeController;
  late TextEditingController originCityController;
  late TextEditingController destinationTimeController;
  late TextEditingController destinationCityController;
  //Hotel Controller
  late TextEditingController hotelNameController;
  late TextEditingController hotelCityController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  //Transportation Controller
  late TextEditingController airportToHotelController;
  late TextEditingController internallController;
  late TextEditingController hotelToairportController;

  late TextEditingController dayNameController;
  late TextEditingController dayTitleController;
  late TextEditingController dayDetailsController;

  // Image Lists
  List<Uint8List> selectedPackageImgs = [];
  List<Uint8List> selectedHotelImgs = [];
  List<Uint8List> selectedServiceImgs = [];
  // Image URL LIst
  var imgServiceUrls = [];
  RxBool isServiceImgLoding = false.obs;
  RxBool isServiceImgFinish = false.obs;

  var imgPackageUrls = [];
  RxBool isPackageImgLoding = false.obs;
  RxBool isPackageImgFinish = false.obs;

  var imgHotelUrls = [];
  RxBool isHotelImgLoading = false.obs;
  RxBool isHotelImgFinish = false.obs;

  //Date & Time
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  //Stepper Counter
  RxInt cureentStep = 0.obs;

  //Category Info
  RxString? categoryId = ''.obs;
  var category = [].obs;
  RxString selectedCategory = ''.obs;

  //Rating
  RxString? rating = '0.0'.obs;

  //Form Counter
  RxInt? formCount = 1.obs;
  RxInt? formPriceCount = 1.obs;
  RxInt? formIcludedCount = 1.obs;
  RxInt? formExcludedCount = 1.obs;
//
  var dayController = <TextEditingController>[].obs;
  var titleController = <TextEditingController>[].obs;
  var detailsController = <TextEditingController>[].obs;
  var dailyInterList = [].obs;
//
  var titlePriceController = <TextEditingController>[].obs;
  var priceDetailsController = <TextEditingController>[].obs;
  var priceDetalisList = [].obs;

  //

  var includedController = <TextEditingController>[].obs;
  var includedList = [].obs;

  //

  var excludedController = <TextEditingController>[].obs;
  var excludedList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();

    countryController = TextEditingController();
    cityController = TextEditingController();
    durationController = TextEditingController();
    priceController = TextEditingController();
    oldPriceController = TextEditingController();
    airPortController = TextEditingController();
    flightNumberController = TextEditingController();
    flightDateController = TextEditingController();
    flightTimeController = TextEditingController();
    originCityController = TextEditingController();
    destinationTimeController = TextEditingController();
    destinationCityController = TextEditingController();
    hotelNameController = TextEditingController();
    hotelCityController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    airportToHotelController = TextEditingController();
    internallController = TextEditingController();
    hotelToairportController = TextEditingController();

    dayNameController = TextEditingController();
    dayTitleController = TextEditingController();
    dayDetailsController = TextEditingController();

    for (var i = 0; i < formCount!.value; i++) {
      dayController.add(TextEditingController());
      titleController.add(TextEditingController());
      detailsController.add(TextEditingController());
    }

    for (var i = 0; i < formPriceCount!.value; i++) {
      titlePriceController.add(TextEditingController());
      priceDetailsController.add(TextEditingController());
    }

    for (var i = 0; i < formIcludedCount!.value; i++) {
      includedController.add(TextEditingController());
    }

    for (var i = 0; i < formExcludedCount!.value; i++) {
      excludedController.add(TextEditingController());
    }
  }

  @override
  void onClose() {
    countryController.clear();
    countryController.dispose();
    cityController.clear();
    cityController.dispose();
    durationController.clear();
    durationController.dispose();
    priceController.clear();
    priceController.dispose();
    oldPriceController.clear();
    oldPriceController.dispose();
    airPortController.clear();
    airPortController.dispose();
    flightNumberController.clear();
    flightNumberController.dispose();
    flightDateController.clear();
    flightDateController.dispose();
    flightTimeController.clear();
    flightTimeController.dispose();
    originCityController.clear();
    originCityController.dispose();
    destinationTimeController.clear();
    destinationTimeController.dispose();
    destinationCityController.clear();
    destinationCityController.dispose();
    hotelNameController.clear();
    hotelNameController.dispose();
    hotelCityController.clear();
    hotelCityController.dispose();
    startDateController.clear();
    startDateController.dispose();
    endDateController.clear();
    endDateController.dispose();
    airportToHotelController.clear();
    airportToHotelController.dispose();
    internallController.clear();
    internallController.dispose();
    hotelToairportController.clear();
    hotelToairportController.dispose();
    dayNameController.clear();
    dayNameController.dispose();
    dayTitleController.clear();
    dayTitleController.dispose();
    dayDetailsController.clear();
    dayDetailsController.dispose();
    dayController.clear();
    titleController.clear();
    detailsController.clear();
    titlePriceController.clear();
    priceDetailsController.clear();
    includedController.clear();
    excludedController.clear();
  }

  void createDailyItineraryController() {
    dayController.add(TextEditingController());
    titleController.add(TextEditingController());
    detailsController.add(TextEditingController());
  }

  void createPriceDetailsController() {
    titlePriceController.add(TextEditingController());
    priceDetailsController.add(TextEditingController());
  }

  void createIncludedController() {
    includedController.add(TextEditingController());
  }

  void createExcludedController() {
    excludedController.add(TextEditingController());
  }

  Future<void> fetchCategories() async {
    category.clear();
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((categorties) {
        category.add(categorties.data()['name']);
        selectedCategory.value = category[0];
      });
    });
  }

  Future<void> pickPackageImages() async {
    if (selectedPackageImgs != null && imgPackageUrls != null) {
      selectedPackageImgs.clear();
      imgPackageUrls.clear();
    }
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      isPackageImgLoding.value = true;

      for (int i = 0; i < result!.count; i++) {
        Uint8List fileBytes = result.files[i].bytes!;
        await FirebaseStorage.instance
            .ref('uploads/packages/${result.files[i].name}')
            .putData(fileBytes);

        FirebaseStorage.instance
            .ref('uploads/packages/${result.files[i].name}')
            .getDownloadURL()
            .then((url) {
          imgPackageUrls.add(url.toString());
          print(imgPackageUrls);
        });
      }
    } catch (e) {
      print(e);
    }

    isPackageImgLoding.value = false;

    Future.delayed(const Duration(milliseconds: 3000), () {
      isPackageImgFinish.value = false;
    });
  }

  Future<void> pickHotelImages() async {
    if (selectedHotelImgs != null && imgHotelUrls != null) {
      selectedHotelImgs.clear();
      imgHotelUrls.clear();
    }
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      isHotelImgLoading.value = true;

      for (int i = 0; i < result!.count; i++) {
        Uint8List fileBytes = result.files[i].bytes!;
        await FirebaseStorage.instance
            .ref('uploads/hotels/photos/${result.files[i].name}')
            .putData(fileBytes);

        FirebaseStorage.instance
            .ref('uploads/hotels/photos/${result.files[i].name}')
            .getDownloadURL()
            .then((url) {
          imgHotelUrls.add(url.toString());
        });
      }
    } catch (e) {
      print(e);
    }

    isHotelImgLoading.value = false;

    Future.delayed(const Duration(milliseconds: 3000), () {
      isHotelImgFinish.value = false;
    });
  }

  Future<void> pickServiceImages() async {
    if (selectedServiceImgs != null && imgServiceUrls != null) {
      selectedServiceImgs.clear();
      imgServiceUrls.clear();
    }
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      isServiceImgLoding.value = true;

      for (int i = 0; i < result!.count; i++) {
        Uint8List fileBytes = result.files[i].bytes!;
        await FirebaseStorage.instance
            .ref('uploads/hotels/services/${result.files[i].name}')
            .putData(fileBytes);

        FirebaseStorage.instance
            .ref('uploads/hotels/services/${result.files[i].name}')
            .getDownloadURL()
            .then((url) {
          imgServiceUrls.add(url.toString());
        });
      }
    } catch (e) {
      print(e);
    }

    isHotelImgLoading.value = false;

    Future.delayed(const Duration(milliseconds: 3000), () {
      isServiceImgFinish.value = false;
    });
  }

  void chooseDate(TextEditingController? controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        helpText: 'Select Flight Date',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'Flight Date',
        fieldHintText: 'Month/Date/Year',
        selectableDayPredicate: disableDate);
    if (pickedDate != null && pickedDate != selectedDate.value) {
      controller!.text = DateFormat.yMMMd().format(pickedDate).toString();
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  chooseTime(TextEditingController? controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: selectedTime.value,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        },
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Select Flight Time',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorInvalidText: 'Provide valid time',
        hourLabelText: 'Select Hour',
        minuteLabelText: 'Select Minute');
    if (pickedTime != null && pickedTime != selectedTime.value) {
      controller!.text = '${pickedTime.hour}:${pickedTime.minute}';
    }
  }

  void addDailyItinerary() {
    for (var i = 0; i < dayController.length; i++) {
      dailyInterList.add({
        'day_name': dayController[i].text,
        'day_title': titleController[i].text,
        'day_detalis': detailsController[i].text,
      });
    }
  }

  void addPriceDetails() {
    for (var i = 0; i < titlePriceController.length; i++) {
      priceDetalisList.add({
        'title_price': titlePriceController[i].text,
        'price_details': priceDetailsController[i].text,
      });
    }
  }

  void addIncludedDetails() {
    for (var i = 0; i < includedController.length; i++) {
      includedList.add({
        'included_title': includedController[i].text,
      });
    }
  }

  void addExcludedDetails() {
    for (var i = 0; i < excludedController.length; i++) {
      excludedList.add({
        'excluded_title': excludedController[i].text,
      });
    }
  }

  Future<void> addNewPackage(
    String? country,
    dynamic pacakgeImgs,
    String? city,
    String? duration,
    double price,
    double oldPrice,
    String? categoryName,
    String? airportName,
    String? flightNum,
    String? date,
    String? originTime,
    String? originCity,
    String? destinationTime,
    String? destinationCity,
    String? hotelName,
    String? hotelCity,
    String? startDate,
    String? endDate,
    double rating,
    dynamic hotelImgs,
    dynamic serviceImgs,
    String? airportToHotel,
    String? internal,
    String? hotelToairport,
    dynamic dailyItinerary,
    dynamic priceDetails,
    dynamic includedDetails,
    dynamic excludedDetails,
  ) async {
    EasyLoading.show(status: 'loading...');

    await FirebaseFirestore.instance.collection('categories').get().then(
      (values) {
        values.docs.forEach(
          (element) {
            if (element['name'] == selectedCategory.value) {
              categoryId!.value = element.id.toString();
            }
          },
        );
      },
    );

    Map<String, dynamic> demoData = {
      'country': country,
      'image_paths': pacakgeImgs,
      'city': city,
      'duration': duration,
      'price': price,
      'old_price': oldPrice,
      'category_id': categoryId!.value,
      'flight_detalis': {
        'airport_name': airportName,
        'flight_number': flightNum,
        'date': date,
        'origin_time': originTime,
        'origin_city': originCity,
        'destination_time': destinationTime,
        'destination_city': destinationCity,
      },
      'hotel_detalis': {
        'hotel_name': hotelName,
        'hotel_city': hotelCity,
        'start_date': startDate,
        'end_date': endDate,
        'rating': rating,
        'photos': hotelImgs,
        'services': serviceImgs,
      },
      'transportation_details': {
        'airport_to_hotel': airportToHotel,
        'internal': internal,
        'hotel_to_airport': hotelToairport,
      },
      'daily_itinerary': dailyItinerary,
      'price_details': priceDetails,
      'included': includedDetails,
      'excluded': excludedDetails,
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('packages');
    collectionReference.add(demoData).then((value) {});

    EasyLoading.dismiss();
  }
}
