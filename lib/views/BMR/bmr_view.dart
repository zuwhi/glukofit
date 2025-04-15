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

      controller.weight.value =
          authController.userData.value['berat'].toString();
    }
    if (authController.userData.value['tinggi'] != null) {
      controller.height.value =
          authController.userData.value['tinggi'].toString();
    }
    if (authController.userData.value['umur'] != null) {
      controller.age.value = authController.userData.value['umur'].toString();
    }

    final ageController = TextEditingController(text: controller.age.value);
    final weightController =
        TextEditingController(text: controller.weight.value);
    final heightController =
        TextEditingController(text: controller.height.value);

    final List<String> listOption = [
      'Suka Rebahan',
      'Aktivitas ringan, olahraga 1-2 kali/minggu',
      'Aktivitas sedang, olahraga 3-5 kali/minggu',
      'Aktivitas berat, olahraga 6-7 kali/minggu,',
      'Aktivitas ekstrim, olahraga 2 kali sehari atau lebih',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung Kalorimu"),
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
                                const DialogBMR(),
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
                                    text: "Apa Itu BMR & TDEE ?",
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
                          controller.age.value = value;
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
                                  text: "berat (kg)  ",
                                  color: Colors.grey[600],
                                ),
                                onChanged: (value) {
                                  controller.weight.value = value;
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
                                  text: "tinggi (cm)  ",
                                  color: Colors.grey[600],
                                ),
                                onChanged: (value) {
                                  controller.height.value = value;
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
                                    mainAxisSize: MainAxisSize.min,
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
                                        "${controller.kaloriTotal.value.toInt()} adalah jumlah rata-rata kalori  yang kamu butuhkan saat ini. ingin menyimpannya sebagai pengingat ?",
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
                                              text: "Simpan",
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
                            isActive: controller.weight.value != '' &&
                                controller.height.value != '' &&
                                controller.age.value != '' &&
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

class DialogBMR extends StatelessWidget {
  const DialogBMR({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(13),
      title: TextPrimary(
        text: "Apa Itu BMR dan TDEE?",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
      content: TextPrimary(
        textAlign: TextAlign.justify,
        text:
            '''Basal Metabolic Rate (BMR) adalah jumlah energi yang tubuhmu butuhkan untuk menjalankan fungsi dasar seperti bernapas, menjaga suhu tubuh, dan mencerna makanan saat kamu dalam keadaan istirahat. 
Total Daily Energy Expenditure (TDEE) adalah jumlah total kalori yang dibakar tubuh Anda dalam satu hari, termasuk kalori yang dibutuhkan untuk fungsi dasar tubuh (BMR) dan kalori yang digunakan untuk aktivitas fisik seperti bekerja, berolahraga, dan aktivitas sehari-hari lainnya. TDEE digunakan untuk menentukan berapa banyak kalori yang perlu Anda konsumsi setiap hari untuk mencapai tujuan berat badan Anda. Jika Anda ingin mempertahankan berat badan, Anda harus mengonsumsi kalori sebanyak TDEE Anda. Jika Anda ingin menurunkan berat badan, Anda harus mengonsumsi sedikit lebih sedikit dari TDEE Anda, dan jika Anda ingin menambah berat badan, Anda perlu mengonsumsi lebih banyak kalori daripada TDEE Anda. Perhitungan ini membantu dalam merencanakan pola makan yang sesuai dengan kebutuhan energi dan tujuan kesehatan Anda..
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
    );
  }
}
