import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/models/bmr_model.dart';
import 'package:glukofit/services/appwrite_bmr.dart';
import 'package:logger/logger.dart';

enum Gender { empty, male, female }

class BmrController extends GetxController {
  RxString age = ''.obs;
  RxString height = ''.obs;
  RxString weight = ''.obs;

  RxDouble bmr = 0.0.obs;
  RxDouble tdee = 0.0.obs;
  RxDouble kaloriTotal = 0.0.obs;
  RxBool isLoading = false.obs;

  final option = Rx<String?>(null);

  final gender = Gender.empty.obs;
  AppwriteBmrService bmrService = AppwriteBmrService();

  void hitungBmr() {
    if (gender.value == Gender.empty) {
      return;
    } else if (gender.value == Gender.male) {
      bmr.value =
          (10 * double.parse(weight.value)) + (6.25 * double.parse(height.value)) - (5 * double.parse(age.value)) + 5;
    } else if (gender.value == Gender.female) {
      bmr.value =
          (10 * double.parse(weight.value)) + (6.25 * double.parse(height.value)) - (5 * double.parse(age.value)) - 161;
    }

    kaloriTotal.value = bmr.value * tdee.value;
    Logger().d(kaloriTotal);
  }

  void simpan(BMRModel model) async {
    try {
      isLoading.value = true;
      await bmrService.addBmr(model);
      Get.offAllNamed(AppRoutes.tracker);
    } catch (e) {
      Get.snackbar(
        'Error',
        "Terjadi kesalahan",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateBmr(BMRModel model) async {
    try {
      isLoading.value = true;
      await bmrService.updateBmr(model);
      Get.offAllNamed(AppRoutes.tracker);
    } catch (e) {
      Get.snackbar(
        'Error',
        "Terjadi kesalahan",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
