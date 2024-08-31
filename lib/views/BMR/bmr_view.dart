// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/bmr_controller.dart';
import 'package:glukofit/models/bmr_model.dart';
import 'package:glukofit/views/diagnosa/widgets/card_question_widget.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_choice_chip_widget.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_form_diagnose_widget.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class BmrView extends StatelessWidget {
  const BmrView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    String bmrId = arguments['bmrId'];

    final AuthController authController = Get.find();
    final BmrController controller = Get.put(BmrController());
    if (authController.userData.value['berat'] != null) {
      controller.weight.value = authController.userData.value['berat'];
    }
    if (authController.userData.value['tinggi'] != null) {
      controller.height.value = authController.userData.value['tinggi'];
    }
    if (authController.userData.value['umur'] != null) {
      controller.age.value = authController.userData.value['umur'];
    }

    final ageController =
        TextEditingController(text: controller.age.value.toString());
    final weightController =
        TextEditingController(text: controller.weight.value.toString());
    final heightController =
        TextEditingController(text: controller.height.value.toString());

    final List<String> listOption = [
      'Suka Rebahan',
      'Aktivitas ringan, olahraga 1-2 kali/minggu',
      'Aktivitas sedang, olahraga 3-5 kali/minggu',
      'Aktivitas berat, olahraga 6-7 kali/minggu,',
      'Aktivitas ekstrim, olahraga 2 kali sehari atau lebih',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMR"),
        centerTitle: true,
        actions: const [],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.dialog(
                                AlertDialog(
                                  backgroundColor: Colors.white,
                                  insetPadding: const EdgeInsets.all(13),
                                  title: TextPrimary(
                                    text: "Apa Itu BMR ?",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                  content: TextPrimary(
                                    textAlign: TextAlign.justify,
                                    text:
                                        '''Basal metabolic rate (BMR) adalah kalori yang tubuh Anda perlukan untuk melakukan aktivitas dasar tubuh seperti bernapas dan memompa darah saat tubuh sedang beristirahat. Memahami BMR penting dalam pencegahan diabetes karena membantu dalam mengatur asupan kalori harian yang tepat. Dengan menjaga kalori yang dikonsumsi sesuai dengan BMR, seseorang dapat menghindari kelebihan berat badan, yang merupakan salah satu faktor risiko utama untuk diabetes tipe 2. Mengatur asupan kalori dan menjaga berat badan ideal dapat membantu mencegah resistensi insulin dan menjaga kadar gula darah tetap normal, yang merupakan langkah penting dalam mencegah diabetes.
        ''',
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
                                    text: "Apa Itu BMR ?",
                                    fontSize: 16.0,
                                    color: Colors.blue[900],
                                  ),
                                ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CardQuestionWidget(
                        text: '1. Pilih gender',
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: CustomChoiceChipWidget(
                                label: 'Laki-laki',
                                selected:
                                    controller.gender.value == Gender.male,
                                onSelected: (selected) {
                                  controller.gender.value = Gender.male;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: CustomChoiceChipWidget(
                                label: 'Perempuan',
                                selected:
                                    controller.gender.value == Gender.female,
                                onSelected: (selected) {
                                  controller.gender.value = Gender.female;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CardQuestionWidget(
                        text: '2. Berapakah umur anda saat ini ?',
                      ),
                      const SizedBox(height: 10.0),
                      CustomFormDiagnoseWidget(
                        keyboardType: TextInputType.number,
                        controller: ageController,
                        hintText: "Masukkan Umur",
                        onChanged: (value) {
                          controller.age.value = int.parse(value);
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CardQuestionWidget(
                        text: '3. Masukkan ukuran tubuh',
                      ),
                      const SizedBox(height: 10.0),
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: CustomFormDiagnoseWidget(
                                keyboardType: TextInputType.number,
                                controller: heightController,
                                hintText: "Tinggi",
                                suffixIcon: TextPrimary(
                                  text: "cm  ",
                                  color: Colors.grey[600],
                                ),
                                onChanged: (value) {
                                  controller.height.value = int.parse(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CardQuestionWidget(
                        text: '4. Pilih salah satu',
                      ),
                      const SizedBox(height: 10.0),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            border: Border.all(
                              width: 0.4,
                              color: Colors.grey[400]!,
                            ),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            borderRadius: BorderRadius.circular(25),
                            // menuWidth: double.infinity,
                            focusColor: AppColors.orange,
                            hint: const Text('klik disini'),
                            value: listOption.contains(controller.option.value)
                                ? controller.option.value
                                : null,
                            items: listOption.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: TextPrimary(
                                  fontSize: 15.0,
                                  text: value,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller.option.value = newValue!;

                              if (newValue == 'Suka Rebahan') {
                                controller.tdee.value = 1.2;
                              } else if (newValue ==
                                  'Aktivitas ringan, olahraga 1-2 kali/minggu') {
                                controller.tdee.value = 1.375;
                              } else if (newValue ==
                                  'Aktivitas sedang, olahraga 3-5 kali/minggu') {
                                controller.tdee.value = 1.550;
                              } else if (newValue ==
                                  'Aktivitas berat, olahraga 6-7 kali/minggu,') {
                                controller.tdee.value = 1.725;
                              } else if (newValue ==
                                  'Aktivitas ekstrim, olahraga 2 kali sehari atau lebih') {
                                controller.tdee.value = 1.9;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          ButtonPrimary(
                            text: "Hitung",
                            onPressed: () {
                              controller.hitungBmr();
                              Get.dialog(Dialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Untuk memastikan dialog sesuai dengan konten
                                    children: [
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Kalori : ${controller.kaloriTotal.value.toInt()}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "${controller.kaloriTotal.value.toInt()} adalah jumlah kalori maximal yang kamu butuhkan saat ini. ingin menyimpannya sebagai pengingat ?",
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: TextPrimary(
                                                text: "Tidak",
                                                color: AppColors.primary,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: ButtonPrimary(
                                              text: "Iya",
                                              onPressed: () {
                                                final BMRModel model = BMRModel(
                                                    id: bmrId,
                                                    userId: authController
                                                        .userData.value["\$id"],
                                                    total: controller
                                                        .kaloriTotal.value);
                                                if (bmrId == '') {
                                                  controller.simpan(model);
                                                } else {
                                                  controller.updateBmr(model);
                                                }
                                              },
                                              isActive: true,
                                              backgroundColor:
                                                  AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            },
                            isActive: controller.weight.value != 0 &&
                                controller.height.value != 0 &&
                                controller.age.value != 0 &&
                                controller.option.value != null &&
                                controller.gender.value != Gender.empty,
                            backgroundColor: AppColors.orange,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
