// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/diagnosa_controller.dart';
import 'package:glukofit/views/diagnosa/widgets/card_question_widget.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_choice_chip_widget.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_form_diagnose_widget.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:logger/logger.dart';

class QuestionOneSectionWidget extends StatelessWidget {
  const QuestionOneSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DiagnosaController controller = Get.put(DiagnosaController());
    final ageController = TextEditingController(text: controller.age.value);
    final weightController =
        TextEditingController(text: controller.weight.value);
    final heightController =
        TextEditingController(text: controller.height.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CardQuestionWidget(
          text: '1. Berapakah umur anda saat ini ?',
        ),
        const SizedBox(height: 10.0),
        CustomFormDiagnoseWidget(
          keyboardType: TextInputType.number,
          ageController: ageController,
          hintText: "Masukkan Umur",
          onChanged: (value) {
            controller.updateAge(value);
            controller.updateDiagnosaModel(0, [ageController.text.toString()]);
          },
        ),
        const SizedBox(
          height: 25.0,
        ),
        CardQuestionWidget(
          text: '2. Masukkan ukuran tubuh',
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: CustomFormDiagnoseWidget(
                  keyboardType: TextInputType.number,
                  ageController: weightController,
                  hintText: "Berat",
                  suffixIcon: TextPrimary(
                    text: "kg  ",
                    color: Colors.grey[600],
                  ),
                  onChanged: (value) {
                    controller.updateWeight(value);
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: CustomFormDiagnoseWidget(
                  keyboardType: TextInputType.number,
                  ageController: heightController,
                  hintText: "Tinggi",
                  suffixIcon: TextPrimary(
                    text: "cm  ",
                    color: Colors.grey[600],
                  ),
                  onChanged: (value) {
                    controller.updateHeight(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Obx(() {
          final bmi = controller.calculateBMI();
          return Text('BMI: ${bmi.toStringAsFixed(2)}');
        }),
        const SizedBox(
          height: 15.0,
        ),
        CardQuestionWidget(
          text: '3. Pilih gender',
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(() => CustomChoiceChipWidget(
              label: 'Laki-laki',
              selected: const ListEquality()
                  .equals(controller.diagnosaModel.value.gender, ['Male']),
              onSelected: (selected) {
                controller.updateDiagnosaModel(1, selected ? ["Male"] : []);
              },
            )),
        const SizedBox(
          height: 10.0,
        ),
        Obx(() => CustomChoiceChipWidget(
              label: 'Perempuan',
              selected: const ListEquality()
                  .equals(controller.diagnosaModel.value.gender, ['Female']),
              onSelected: (selected) {
                controller.updateDiagnosaModel(1, selected ? ["Female"] : []);
              },
            )),
        const SizedBox(
          height: 90.0,
        ),
        Obx(
          () => ButtonPrimary(
            backgroundColor: AppColors.orange,
            isActive: controller.question1.value,
            onPressed: () {
              Logger().d(controller.diagnosaModel.value.toJson());
              controller.updateCurrentIndex(2);
            },
            text: "Next",
          ),
        )
      ],
    );
  }
}
