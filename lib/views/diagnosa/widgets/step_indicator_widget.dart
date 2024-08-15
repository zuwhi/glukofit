// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/diagnosa_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepIndicatorWidget extends StatelessWidget {
  const StepIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DiagnosaController controller = Get.put(DiagnosaController());
    return Obx(
      () => StepProgressIndicator(
        size: 8,
        roundedEdges: const Radius.circular(25),
        totalSteps: 3,
        currentStep: controller.currentIndex.value,
        selectedColor: AppColors.orange,
        unselectedColor: Colors.grey.shade300,
        onTap: (index) => () => controller.updateCurrentIndex(index + 1),
      ),
    );
  }
}
