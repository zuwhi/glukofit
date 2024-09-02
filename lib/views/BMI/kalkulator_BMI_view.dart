// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/bmi_controller.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_form_diagnose_widget.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class KalkulatorBmiView extends StatelessWidget {
  const KalkulatorBmiView({super.key});

  @override
  Widget build(BuildContext context) {
    final BmiController controller = Get.put(BmiController());
    final ageController =
        TextEditingController(text: controller.age.value.toString());
    final weightController =
        TextEditingController(text: controller.weight.value.toString());
    final heightController =
        TextEditingController(text: controller.height.value.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextPrimary(
          text: 'Kalkulator Ideal',
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.dashboard);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.white,
                          title: TextPrimary(
                            text: "Apa Itu BMI ?",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                          content: TextPrimary(
                            text:
                                "Body mass index (BMI) atau indeks massa tubuh adalah perkiraan lemak tubuh yang didasarkan pada berat dan tinggi badan. Perhitungan ini dapat membantu menentukan apakah kamu memiliki berat badan yang kurang, berat badan sehat, kelebihan berat badan, atau obesitas.",
                            fontSize: 15.0,
                            color: Colors.grey[600],
                          ),
                          // actions: [
                          //   TextButton(
                          //     child: const Text("tutup"),
                          //     onPressed: () {
                          //       Get.back();
                          //     },
                          //   ),
                          // ],
                        ),
                      );
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            size: 20,
                            color: Colors.blue[900],
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          TextPrimary(
                            text: "Apa Itu BMI ?",
                            fontSize: 16.0,
                            color: Colors.blue[900],
                          ),
                        ]),
                  )
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              SizedBox(
                  height: 310,
                  child: Obx(() => controller.status.value != ""
                      ? Column(
                          children: [
                            SizedBox(
                              height: 310,
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                    minimum: 10,
                                    maximum: 40,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                          startValue: 0,
                                          endValue: 18.49,
                                          color: Colors.yellow,
                                          startWidth: 20,
                                          endWidth: 20),
                                      GaugeRange(
                                          startValue: 18.5,
                                          endValue: 24.9,
                                          color: Colors.green,
                                          startWidth: 20,
                                          endWidth: 20),
                                      GaugeRange(
                                          startValue: 25,
                                          endValue: 27,
                                          color: Colors.orange,
                                          startWidth: 20,
                                          endWidth: 20),
                                      GaugeRange(
                                          startValue: 27,
                                          endValue: 40,
                                          color: Colors.red,
                                          startWidth: 20,
                                          endWidth: 20)
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(value: controller.bmi.value)
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Obx(
                                            () => TextPrimary(
                                              text: controller.status.value,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                              color: controller.color.value,
                                            ),
                                          ),
                                          angle: 90,
                                          positionFactor: 0.5)
                                    ])
                              ]),
                            ),
                          ],
                        )
                      : SvgPicture.asset("assets/svg/count.svg"))),
              TextPrimary(text: "Masukkan berat (kg)"),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomFormDiagnoseWidget(
                              keyboardType: TextInputType.number,
                              controller: weightController,
                              hintText: "Berat",
                              suffixIcon: TextPrimary(
                                text: "kg  ",
                                color: Colors.grey[600],
                              ),
                              onChanged: (value) {
                                controller.weight.value = int.parse(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextPrimary(text: "Masukkan tinggi (cm)"),
              HorizontalPicker(
                minValue: 60,
                maxValue: 248,
                divisions: 188,
                height: 100,
                showCursor: false,
                activeItemTextColor: AppColors.orange,
                initialPosition: InitialPosition.center,
                // cursorColor: AppColors.primary,
                passiveItemsTextColor: AppColors.orange.withOpacity(0.3),
                onChanged: (value) {
                  controller.height.value = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    ButtonPrimary(
                      text: "Hitung",
                      onPressed: () {
                        controller.hitungBmi();
                      },
                      isActive: true,
                      backgroundColor: AppColors.orange,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
