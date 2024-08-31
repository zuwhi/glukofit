import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
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
                TextPrimary(
                  text: "Total kalori : ${controller.totalKalori.value} kkal",
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Jumlah Kalori : ${tracker.kalori.toString()} kal",
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
