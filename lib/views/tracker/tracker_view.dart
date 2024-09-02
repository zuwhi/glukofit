// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/tracker_controller.dart';
import 'package:glukofit/views/global_widgets/bottom_sheet_add_nutrition_widget.dart';
import 'package:glukofit/views/tracker/widgets/card_pantau_kalori.dart';
import 'package:glukofit/views/tracker/widgets/timeline_history_widget.dart';
import 'package:intl/intl.dart';

class TrackerView extends StatelessWidget {
  const TrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    final TrackerController controller = Get.put(TrackerController());
    final AuthController authController = Get.find();

    controller.countKalori(authController.userData.value['\$id']);

    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Get.bottomSheet(const BottomSheetAddNutritionWidget());
          },
          backgroundColor: AppColors.orange,
          child: const Icon(
            size: 30,
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              "Pantau Kalori",
              style: TextStyle(
                color: Colors.black,
                fontSize: 21.0,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashboard);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))),
        body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            // Tambahkan delay untuk simulasi proses refresh
            await Future.delayed(const Duration(seconds: 1));
            controller.getListTracker();
          },
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: AppColors.primary,
                          border: Border.all(
                            color: AppColors.primary,
                          )),
                      height: 180,
                      padding: const EdgeInsets.all(16.0),
                      child: controller.isLoadingGetBMR.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            )
                          : CardPantauKalori(controller: controller),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Obx(
                    () => EasyDateTimeLine(
                        initialDate:
                            controller.stringToDate(controller.today.value),
                        locale: "ID",
                        dayProps: const EasyDayProps(
                          height: 80,
                          width: 65,
                          dayStructure: DayStructure.monthDayNumDayStr,
                          todayHighlightColor: AppColors.primary,
                          activeDayStyle: DayStyle(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: AppColors.primary),
                          ),
                        ),
                        onDateChange: (selectedDate) {
                          controller.pickedTime.value =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                          controller.getListTracker();
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 10),
                child: TimelinePage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
