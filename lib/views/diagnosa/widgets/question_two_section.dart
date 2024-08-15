// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_helpers.dart';
import 'package:glukofit/controllers/diagnosa_controller.dart';
import 'package:glukofit/views/diagnosa/widgets/card_question_widget.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_choice_chip_widget.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';

class QuestionTwoSectionWidget extends StatelessWidget {
  const QuestionTwoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ageController = TextEditingController();
    final DiagnosaController controller = Get.put(DiagnosaController());

    return Column(
      children: [
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(2),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.polyuria, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(2, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.polyuria, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(2, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),

        // pertanyaan ke 3
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(3),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.polydipsia, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(3, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.polydipsia, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(3, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 4
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(4),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality().equals(
                controller.diagnosaModel.value.suddenWeightLoss, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(4, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality().equals(
                controller.diagnosaModel.value.suddenWeightLoss, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(4, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 5
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(5),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.weakness, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(5, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.weakness, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(5, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 6
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(6),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.polyphagia, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(6, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.polyphagia, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(6, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 7
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(7),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.genitalThrush, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(7, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.genitalThrush, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(7, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),

        // pertanyaan ke 8
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(8),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.visualBlurring, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(8, selected ? ["Yes"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Tidak",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.visualBlurring, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(8, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),

        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: ButtonPrimary(
                isActive: true,
                text: "Back",
                onPressed: () {
                  controller.updateCurrentIndex(1);
                },
              )),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Obx(
                () => ButtonPrimary(
                    text: "Next",
                    backgroundColor: AppColors.orange,
                    isActive: controller.question2.value,
                    onPressed: () {
                      controller.updateCurrentIndex(3);
                    }),
              )),
            ],
          ),
        )
      ],
    );
  }
}
