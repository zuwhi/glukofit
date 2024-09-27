import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_constant.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/models/diagnosa_model.dart';


class DiagnosaController extends GetxController {
  RxInt currentIndex = 1.obs;
  RxString weight = ''.obs;
  RxString height = ''.obs;
  RxString age = ''.obs;
  RxBool question1 = false.obs;
  RxBool question2 = false.obs;
  RxBool question3 = false.obs;
  RxBool isLoading = false.obs;

  Future<void> sendRequest() async {
    try {
      isLoading.value = true;
      Dio dio = Dio();
      String url = AppConstant.urlDiagnose;

      final res =
          await dio.post('$url/predict', data: diagnosaModel.value.toJson());

      final response = res.data["predictions"][0];
      if (response != null) {
        Get.toNamed(AppRoutes.resultDiagnosa,
            arguments: {'diagnosa': response});
      }
    } catch (e) {
      Get.snackbar('Error', "Maaf terjadi kesalahan ");
    } finally {
      isLoading.value = false;
    }
  }

  void validateQuestion1() {
    bool isAgeFilled = diagnosaModel.value.age!.isNotEmpty;
    bool isGenderFilled = diagnosaModel.value.gender.isNotEmpty;

    bool isObesityFilled = diagnosaModel.value.obesity!.isNotEmpty &&
        diagnosaModel.value.obesity![0] != '';

    question1.value = isAgeFilled && isGenderFilled && isObesityFilled;

    print('question1: ${question1.value}');
  }

  void validateQuestion2() {
    bool isPolyuraFilled = diagnosaModel.value.polyuria!.isNotEmpty;
    bool isPolydipsiaFilled = diagnosaModel.value.polydipsia!.isNotEmpty;
    bool isSuddenWeightLossFilled =
        diagnosaModel.value.suddenWeightLoss!.isNotEmpty;
    bool isWeaknessFilled = diagnosaModel.value.weakness!.isNotEmpty;
    bool ispolyphagiaFilled = diagnosaModel.value.polyphagia!.isNotEmpty;
    bool genitalThrushFilled = diagnosaModel.value.genitalThrush!.isNotEmpty;
    bool visualBlurringFilled = diagnosaModel.value.visualBlurring!.isNotEmpty;

    question2.value = isPolyuraFilled &&
        isPolydipsiaFilled &&
        isSuddenWeightLossFilled &&
        isWeaknessFilled &&
        ispolyphagiaFilled &&
        genitalThrushFilled &&
        visualBlurringFilled;

    print('question2: ${question2.value}');
  }

  void validateQuestion3() {
    bool itchingFilled = diagnosaModel.value.itching!.isNotEmpty;
    bool irritabilityFilled = diagnosaModel.value.irritability!.isNotEmpty;
    bool delayedHealingFilled = diagnosaModel.value.delayedHealing!.isNotEmpty;
    bool partialParesisFilled = diagnosaModel.value.partialParesis!.isNotEmpty;
    bool muscleStiffnessFilled =
        diagnosaModel.value.muscleStiffness!.isNotEmpty;
    bool alopeciaFilled = diagnosaModel.value.alopecia!.isNotEmpty;

    question3.value = itchingFilled &&
        irritabilityFilled &&
        delayedHealingFilled &&
        partialParesisFilled &&
        muscleStiffnessFilled &&
        alopeciaFilled;

    print('question3: ${question3.value}');
  }

  var diagnosaModel = DiagnosaModel(
    age: [''],
    gender: [''],
    polyuria: [],
    polydipsia: [],
    suddenWeightLoss: [],
    weakness: [],
    polyphagia: [],
    genitalThrush: [],
    visualBlurring: [],
    itching: [],
    irritability: [],
    delayedHealing: [],
    partialParesis: [],
    muscleStiffness: [],
    alopecia: [],
    obesity: [],
  ).obs;

  void updateCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }

  void updateAge(String newAge) {
    age.value = newAge;
    validateQuestion1();
  }

  void updateDiagnosaModel(int index, List<String> newData) {
    switch (index) {
      case 0:
        diagnosaModel.value.age = newData;
        break;
      case 1:
        diagnosaModel.value.gender = newData;
        break;
      case 2:
        diagnosaModel.value.polyuria = newData;
        break;
      case 3:
        diagnosaModel.value.polydipsia = newData;
        break;
      case 4:
        diagnosaModel.value.suddenWeightLoss = newData;
        break;
      case 5:
        diagnosaModel.value.weakness = newData;
        break;
      case 6:
        diagnosaModel.value.polyphagia = newData;
        break;
      case 7:
        diagnosaModel.value.genitalThrush = newData;
        break;
      case 8:
        diagnosaModel.value.visualBlurring = newData;
        break;
      case 9:
        diagnosaModel.value.itching = newData;
        break;
      case 10:
        diagnosaModel.value.irritability = newData;
        break;
      case 11:
        diagnosaModel.value.delayedHealing = newData;
        break;
      case 12:
        diagnosaModel.value.partialParesis = newData;
        break;
      case 13:
        diagnosaModel.value.muscleStiffness = newData;
        break;
      case 14:
        diagnosaModel.value.alopecia = newData;
        break;
      case 15:
        diagnosaModel.value.obesity = newData;
        break;
      default:
        throw Exception("Invalid index");
    }
    diagnosaModel.refresh();
    validateQuestion1();
    validateQuestion2();
    validateQuestion3();
  }

  void updateWeight(String newWeight) {
    weight.value = newWeight;
    validateQuestion1();
  }

  void updateHeight(String newHeight) {
    height.value = newHeight;
    validateQuestion1();
  }

  void updateObesity(double bmi) {
    String result;
    if (bmi > 30) {
      result = 'Yes';
    } else {
      result = 'No';
    }
    diagnosaModel.value.obesity = [result];
  }

  double calculateBMI() {
    final double weightValue = double.tryParse(weight.value) ?? 0;
    final double heightValue = double.tryParse(height.value) ?? 0;

    final double heightInMeters = heightValue / 100;

    if (weightValue > 0 && heightInMeters > 0) {
      double result = weightValue / (heightInMeters * heightInMeters);
      updateObesity(result);
      return result;
    }
    return 0;
  }
}
