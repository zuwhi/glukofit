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

class QuestionThreeSectionWidget extends StatelessWidget {
  const QuestionThreeSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ageController = TextEditingController();
    final DiagnosaController controller = Get.put(DiagnosaController());
    return Column(
      children: [
        // pertanyaan ke 9
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(9),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.itching, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(9, selected ? ["Yes"] : []);
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
                .equals(controller.diagnosaModel.value.itching, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(9, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 10
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(10),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.irritability, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(10, selected ? ["Yes"] : []);
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
                .equals(controller.diagnosaModel.value.irritability, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(10, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 11
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(11),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.delayedHealing, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(11, selected ? ["Yes"] : []);
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
                .equals(controller.diagnosaModel.value.delayedHealing, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(11, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 12
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(12),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.partialParesis, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(12, selected ? ["Yes"] : []);
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
                .equals(controller.diagnosaModel.value.partialParesis, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(12, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 13
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(13),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality().equals(
                controller.diagnosaModel.value.muscleStiffness, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(13, selected ? ["Yes"] : []);
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
                .equals(controller.diagnosaModel.value.muscleStiffness, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(13, selected ? ["No"] : []);
            },
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        // pertanyaan ke 14
        CardQuestionWidget(
          text: AppHelpers.mapIndexToQuestion(14),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(
          () => CustomChoiceChipWidget(
            label: "Iya",
            selected: const ListEquality()
                .equals(controller.diagnosaModel.value.alopecia, ['Yes']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(14, selected ? ["Yes"] : []);
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
                .equals(controller.diagnosaModel.value.alopecia, ['No']),
            onSelected: (selected) {
              controller.updateDiagnosaModel(14, selected ? ["No"] : []);
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
                child: Expanded(
                    child: ButtonPrimary(
                  isActive: true,
                  text: "Back",
                  onPressed: () {
                    controller.updateCurrentIndex(2);
                  },
                )),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: Obx(
                () => ButtonPrimary(
                    isActive: controller.question3.value,
                    backgroundColor: AppColors.orange,
                    text: "Cek Hasil",
                    onPressed: () async {
                      await controller.sendRequest();
                    }),
              )),
            ],
          ),
        )
      ],
    );
  }
}
