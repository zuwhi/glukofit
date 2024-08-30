import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/models/bmr_model.dart';
import 'package:glukofit/services/appwrite_bmr.dart';
import 'package:logger/logger.dart';

enum Gender { empty, male, female }

class BmrController extends GetxController {
  RxInt age = 0.obs;
  RxInt height = 150.obs;
  RxInt weight = 0.obs;

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
          (10 * weight.value) + (6.25 * height.value) - (5 * age.value) + 5;
    } else if (gender.value == Gender.female) {
      bmr.value =
          (10 * weight.value) + (6.25 * height.value) - (5 * age.value) - 161;
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
