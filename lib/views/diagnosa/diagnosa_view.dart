import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/diagnosa_controller.dart';
import 'package:glukofit/views/diagnosa/widgets/question_one_section.dart';
import 'package:glukofit/views/diagnosa/widgets/question_three_section.dart';
import 'package:glukofit/views/diagnosa/widgets/question_two_section.dart';
import 'package:glukofit/views/diagnosa/widgets/step_indicator_widget.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class DiagnosaView extends StatelessWidget {
  const DiagnosaView({super.key});

  @override
  Widget build(BuildContext context) {
    final DiagnosaController controller = Get.put(DiagnosaController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextPrimary(
            text: 'Diagnosa',
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              const StepIndicatorWidget(),
              const SizedBox(
                height: 25.0,
              ),
              Obx(() {
                switch (controller.currentIndex.value) {
                  case 1:
                    return const QuestionOneSectionWidget();
                  case 2:
                    return const QuestionTwoSectionWidget();
                  case 3:
                    return const QuestionThreeSectionWidget();
                  default:
                    return const Center(child: Text('No section available'));
                }
              }),
            ],
          ),
        )));
  }
}
