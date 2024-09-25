import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_helpers.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/tracker_controller.dart';
import 'package:glukofit/models/tracker_model.dart';
import 'package:glukofit/views/global_widgets/bottom_sheet_add_nutrition_widget.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelinePage extends StatelessWidget {
  TimelinePage({super.key});
  final TrackerController controller = Get.put(TrackerController());
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.userId.value = authController.userData.value["\$id"];
    controller.pickedTime.value =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    controller.getListTracker();

    return Obx(
      () => controller.isLoading.value
          ? const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              )),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.white,
                        title: TextPrimary(
                          text: "Kategori Gula",
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        content: Column(
                          children: [
                            TextPrimary(
                              text:
                                  "Warna pada total gula menunujukkan kategori gula anda dengan ketentuan seperti berikut :",
                              fontSize: 15.0,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              children: [
                                TextPrimary(
                                  text: "Rendah: 0 - 25 gram",
                                  fontSize: 15.0,
                                  // color: Colors.grey[600],
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: AppColors.primary,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextPrimary(
                                fontSize: 15.0,
                                color: Colors.grey[600],
                                text:
                                    "Konsumsi di bawah 25 gram per hari dianggap rendah dan berada dalam batasan yang direkomendasikan oleh WHO untuk manfaat kesehatan tambahan."),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                TextPrimary(
                                  text: "Sedang: 26 - 50 gram",
                                  fontSize: 15.0,
                                  // color: Colors.grey[600],
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.orange,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextPrimary(
                                fontSize: 15.0,
                                color: Colors.grey[600],
                                text:
                                    "Konsumsi di bawah 25 gram per hari dianggap rendah dan berada dalam batasan yang direkomendasikan oleh WHO untuk manfaat kesehatan tambahan."),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                TextPrimary(
                                  text: "Tinggi: Lebih dari 50 gram",
                                  fontSize: 15.0,
                                  // color: Colors.grey[600],
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.red[700],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextPrimary(
                                fontSize: 15.0,
                                color: Colors.grey[600],
                                text:
                                    "Konsumsi di atas 50 gram per hari dianggap tinggi dan melebihi batas yang disarankan, yang dapat meningkatkan risiko berbagai masalah kesehatan"),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPrimary(
                        text:
                            "Total gula : ${controller.totalGulaToday.value.toStringAsFixed(2)} g",
                        fontWeight: FontWeight.bold,
                        color: AppHelpers.gramCategory(
                          controller.totalGulaToday.value,
                        ),
                      ),
                      const SizedBox(
                        width: 3.0,
                      ),
                      Icon(Icons.info_outline_rounded,
                          color: AppHelpers.gramCategory(
                            controller.totalGulaToday.value,
                          ),
                          size: 18.0),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: controller.listTracker.value.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final TrackerModel tracker =
                        controller.listTracker.value[index];

                    return TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.04,
                      isFirst: index == 0,
                      isLast: index == controller.listTracker.value.length - 1,
                      indicatorStyle: const IndicatorStyle(
                        width: 20,
                        color: AppColors.primary,
                        indicatorXY: 0.5,
                      ),
                      beforeLineStyle: const LineStyle(
                        color: AppColors.primary,
                        thickness: 3,
                      ),
                      endChild: InkWell(
                        onTap: () {
                          Get.bottomSheet(BottomSheetAddNutritionWidget(
                            isEdit: true,
                            trackFromEdit: controller.listTracker.value[index],
                          ));
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 120,
                          ),
                          margin: const EdgeInsets.only(
                              left: 18, right: 10, top: 15, bottom: 15),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tracker.jam ?? "",
                                style: const TextStyle(
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                tracker.keterangan ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kalori : ${tracker.kalori.toString()} kal,",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "Gula : ${tracker.gula == null ? 0 : tracker.gula.toString()} g",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
