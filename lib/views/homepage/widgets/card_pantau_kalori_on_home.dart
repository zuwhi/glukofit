import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/controllers/tracker_controller.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CardPantauKaloriOnHome extends StatelessWidget {
  const CardPantauKaloriOnHome({
    super.key,
    required this.controller,
  });

  final TrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.bmrTotal.value == 0
                    ? Container()
                    : SizedBox(
                        height: 90,
                        child: SfRadialGauge(axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: controller.bmrTotal.value,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Colors.grey.shade300.withOpacity(0.5),
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value:
                                      controller.totalKalori.value.toDouble(),
                                  color: Colors.white,
                                  cornerStyle: CornerStyle.bothCurve,
                                  width: 0.2,
                                  sizeUnit: GaugeSizeUnit.factor,
                                ),
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.05,
                                    angle: 90,
                                    widget: TextPrimary(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      text:
                                          "${(controller.totalKalori.value / controller.bmrTotal.value * 100).toInt()} %",
                                    ))
                              ])
                        ]),
                      ),
                TextPrimary(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  text:
                      "${(controller.totalKalori.value)} / ${(controller.bmrTotal.value.toInt())} kkal",
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPrimary(
                text: "kalori yang dibutuhkan :",
                fontSize: 13,
                color: Colors.grey.shade200,
                fontWeight: FontWeight.w500,
              ),
              TextPrimary(
                text: "${controller.bmrTotal.value.toInt().toString()} kkal",
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10.0,
              ),
              // InkWell(
              //   onTap: () {
              //     Get.toNamed(AppRoutes.bmr,
              //         arguments: {"bmrId": controller.bmrId.value});
              //   },
              //   child: Container(
              //     width: 140,
              //     height: 40,
              //     decoration: BoxDecoration(
              //       color: Colors.white, // Background color putih
              //       borderRadius: BorderRadius.circular(7), // Radius 15
              //     ),
              //     child: const Center(
              //       child: Text(
              //         'Ubah',
              //         style: TextStyle(
              //           color: AppColors
              //               .primary, // Warna teks bisa diubah sesuai keinginan
              //           fontSize: 16, // Ukuran teks
              //           fontWeight: FontWeight.bold, // Ketebalan teks
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
