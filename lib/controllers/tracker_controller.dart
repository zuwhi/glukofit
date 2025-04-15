import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/models/bmr_model.dart';
import 'package:glukofit/models/tracker_model.dart';
import 'package:glukofit/services/appwrite_bmr.dart';
import 'package:glukofit/services/appwrite_tracker_service.dart';
import 'package:intl/intl.dart';


class TrackerController extends GetxController {
  RxInt tabIndex = 0.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  RxString pickedTime = ''.obs;
  RxString userId = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingGetBMR = false.obs;
  RxInt totalKalori = 0.obs;
  RxInt totalKaloriToday = 0.obs;

  RxDouble totalGulaToday = 0.0.obs;
  RxDouble bmrTotal = 0.0.obs;
  RxString bmrId = ''.obs;

  RxDouble restKalori = 0.0.obs;

  final model = Rx<TrackerModel?>(null);

  final listTracker = Rx<List<TrackerModel>>([]);
  AppwriteTrackerService trackerService = AppwriteTrackerService();
  AppwriteBmrService bmrService = AppwriteBmrService();

  void countKalori(userId) async {
    try {
      isLoadingGetBMR.value = true;
      final BMRModel? response = await bmrService.getBmr(userId);

      bmrTotal.value = response!.total!.toDouble();
      bmrId.value = response.id;

      restKalori.value = bmrTotal.value - totalKaloriToday.value;
    } catch (e) {

      // Get.snackbar(
      //   'Error',
      //   "terjadi kesalahan $e",
      // );
    } finally {
      isLoadingGetBMR.value = false;
    }
  }

  void getListTracker() async {
    isLoading.value = true;
    try {
      final response =
          await trackerService.getListTracker(pickedTime.value, userId.value);
      listTracker.value = response;
      totalKalori.value = 0;
      totalKaloriToday.value = 0;
      totalGulaToday.value = 0;
      for (TrackerModel tracker in listTracker.value) {
        // if (pickedTime.value ==
        //     DateFormat('yyyy-MM-dd').format(DateTime.now())) {
        //   totalKaloriToday.value += tracker.kalori ?? 0;
        //   restKalori.value = bmrTotal.value - totalKaloriToday.value;
        // }
        totalGulaToday.value += tracker.gula ?? 0;
        totalKalori.value += tracker.kalori ?? 0;
        restKalori.value = bmrTotal.value - totalKalori.value;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void getListTrackerToday() async {
    isLoading.value = true;
    try {
      final response = await trackerService.getListTracker(
          DateFormat('yyyy-MM-dd').format(DateTime.now()), userId.value);
      listTracker.value = response;
      totalKalori.value = 0;
      totalKaloriToday.value = 0;
      totalGulaToday.value = 0;
      for (TrackerModel tracker in listTracker.value) {

        totalGulaToday.value += tracker.gula ?? 0;
        totalKalori.value += tracker.kalori ?? 0;
        restKalori.value = bmrTotal.value - totalKalori.value;
      }

    } finally {
      isLoading.value = false;
    }
  }

  void addTracker() async {
    isLoading.value = true;
    try {
      await trackerService.addTracker(model.value!);
      model.value = null;

      getListTracker();
   
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateTracker(TrackerModel tracker) async {
    isLoading.value = true;
    try {
      await trackerService.updateTracker(tracker);
      model.value = null;
      getListTracker();
    } catch (e) {
      Get.snackbar(
        'Error',
        "terjadi kesalahan",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTracker(String id) async {
    isLoading.value = true;
    try {
      await trackerService.deleteTracker(id);
      getListTracker();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;
    }
  }

  RxString today = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  String dateToString(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  DateTime stringToDate(String date) {
    return DateTime.parse(date);
  }
}
