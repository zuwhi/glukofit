import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/tracker_controller.dart';
import 'package:glukofit/models/tracker_model.dart';
import 'package:glukofit/views/diagnosa/widgets/custom_form_diagnose_widget.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class BottomSheetAddNutritionWidget extends StatelessWidget {
  const BottomSheetAddNutritionWidget(
      {super.key,
      this.isEdit = false,
      this.trackFromEdit,
      this.isFromSearch = false});

  final bool isEdit;
  final bool isFromSearch;
  final TrackerModel? trackFromEdit;
  @override
  Widget build(BuildContext context) {
    TextEditingController judulController = TextEditingController(
        text: trackFromEdit != null ? trackFromEdit!.keterangan : '');
    TextEditingController kaloriController = TextEditingController(
        text: trackFromEdit != null ? trackFromEdit!.kalori.toString() : '');

    final TrackerController controller = Get.put(TrackerController());
    if (isEdit && trackFromEdit != null) {
      controller.selectedDate.value = DateTime.parse(trackFromEdit!.tanggal!);
      controller.selectedTime.value = TimeOfDay(
        hour: int.parse(trackFromEdit!.jam!.split(":")[0]),
        minute: int.parse(trackFromEdit!.jam!.split(":")[1]),
      );
    }
    final AuthController authController = Get.find();
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: TextPrimary(
                    text: isEdit ? "Edit Kalori" : "Tambah ke Pantau Kalori",
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextPrimary(
                text: "Keterangan :",
                fontSize: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomFormDiagnoseWidget(
                  keyboardType: TextInputType.text,
                  controller: judulController,
                  hintText: "contoh : makan mendoan",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextPrimary(
                    text: "Jumlah kalori :",
                    fontSize: 15.0,
                  ),
                  isEdit
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.searchNutrisi);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search,
                                  color: Colors.blue[900], size: 16),
                              TextPrimary(
                                text: "Lakukan pencarian",
                                fontSize: 14.0,
                                color: Colors.blue[900],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              CustomFormDiagnoseWidget(
                keyboardType: TextInputType.number,
                controller: kaloriController,
                hintText: "Kalori",
                suffixIcon: TextPrimary(
                  text: "kal  ",
                  color: Colors.grey[600],
                ),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 15.0,
              ),
              DateTimeInput(),
              const SizedBox(
                height: 40.0,
              ),
              isEdit
                  ? Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ButtonPrimary(
                            text: "Hapus",
                            onPressed: () {
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
                                      const Text(
                                        "Konfirmasi",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "Apakah Anda yakin ingin menghapus data ini?",
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
                                                text: "Batal",
                                                color: AppColors.primary,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: ButtonPrimary(
                                              text: "Hapus",
                                              onPressed: () {
                                                controller.deleteTracker(
                                                    trackFromEdit!.id);
                                                controller.getListTracker();
                                                Get.back();
                                              },
                                              isActive: true,
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            },
                            isActive: true,
                            backgroundColor: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: ButtonPrimary(
                            text: "Edit",
                            onPressed: () {
                              final TrackerModel model = TrackerModel(
                                id: trackFromEdit!.id,
                                keterangan: judulController.text,
                                kalori: int.parse(kaloriController.text),
                                userId: authController.userData.value["\$id"],
                                jam: controller.selectedTime.value
                                    .format(context),
                                tanggal: DateFormat('yyyy-MM-dd')
                                    .format(controller.selectedDate.value),
                              );

                              Logger().d(model.toJson());
                              controller.updateTracker(model);
                              controller.getListTracker();
                              Get.back();
                              // Get.offAllNamed(AppRoutes.tracker);
                            },
                            isActive: true,
                            backgroundColor: AppColors.primary,
                          ),
                        )
                      ],
                    )
                  : ButtonPrimary(
                      text: "Simpan",
                      onPressed: () {
                        controller.model.value = TrackerModel(
                          id: '',
                          keterangan: judulController.text,
                          kalori: int.parse(kaloriController.text),
                          userId: authController.userData.value["\$id"],
                          jam: controller.selectedTime.value.format(context),
                          tanggal: DateFormat('yyyy-MM-dd')
                              .format(controller.selectedDate.value),
                        );

                        controller.addTracker();
                        controller.getListTracker();

                        if (isFromSearch) {
                          Get.offAllNamed(AppRoutes.tracker);
                        } else {
                          Get.back();
                        }
                      },
                      isActive: true,
                      backgroundColor: AppColors.orange,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateTimeInput extends StatelessWidget {
  final TrackerController controller = Get.put(TrackerController());

  DateTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Input Tanggal
        Obx(() => Expanded(
              child: GestureDetector(
                onTap: () => controller.pickDate(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPrimary(
                      text: "Tanggal :",
                      fontSize: 15.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
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
                      child: Row(
                        children: [
                          const Icon(
                            Icons.date_range,
                            color: AppColors.primary,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          TextPrimary(
                            text: "${controller.selectedDate.value.toLocal()}"
                                .split(' ')[0],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        const SizedBox(
          width: 15.0,
        ),
        Obx(() => Expanded(
              child: GestureDetector(
                onTap: () => controller.pickTime(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPrimary(
                      text: "Jam :",
                      fontSize: 15.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
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
                      child: Row(
                        children: [
                          const Icon(
                            Icons.more_time_rounded,
                            color: AppColors.primary,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          TextPrimary(
                            text: controller.selectedTime.value
                                .format(context)
                                .split(' ')[0],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
