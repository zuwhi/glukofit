import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BmiController extends GetxController {
  RxInt age = 0.obs;
  RxDouble height = 0.0.obs;
  RxInt weight = 0.obs;
  RxString status = ''.obs;
  RxDouble bmi = 0.0.obs;
  final color = Colors.black.obs;

  hitungBmi() {
    double result =
        weight.value / ((height.value / 100) * (height.value / 100));
    bmi.value = result;
    if (result < 18.5) {
      status.value = 'Kurus';
      color.value = Colors.yellow;
    } else if (result >= 18.5 && result <= 24.9) {
      status.value = 'Normal';
      color.value = Colors.green;
    } else if (result >= 25 && result <= 29.9) {
      status.value = 'Gemuk';
      color.value = Colors.orange;
    } else if (result >= 30) {
      status.value = 'Obesitas';
      color.value = Colors.red;
    }
  }
}
