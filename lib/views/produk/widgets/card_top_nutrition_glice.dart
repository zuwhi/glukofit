import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:glukofit/views/produk/nutrisi_produk_view.dart';
import 'package:glukofit/views/produk/widgets/card_point_nutrition.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CardTopNutritionGlaceWidget extends StatelessWidget {
  const CardTopNutritionGlaceWidget({
    super.key,
    required this.controller,
  });

  final ProdukController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.isLoadingOnTopNutritionView.value
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardPointNutrition(
                      title: "Gula",
                      value:
                          controller.fatsecretTopNutrisiScrap.value!.sugars ??
                              '',
                      image: "gula.png",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CardPointNutrition(
                      title: "Kalori",
                      value: controller
                              .fatsecretTopNutrisiScrap.value!.energyKcal ??
                          "",
                      image: "energi.png",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CardPointNutrition(
                      title: "Protein",
                      value:
                          controller.fatsecretTopNutrisiScrap.value!.protein ??
                              "",
                      image: "protein.png",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CardPointNutrition(
                      title: "Lemak",
                      value:
                          controller.fatsecretTopNutrisiScrap.value!.fat ?? '',
                      image: "lemak.png",
                    ),
                  ],
                ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextPrimary(
                text: "Kategori kadar gula :",
                fontSize: 18.0,
              ),
              Obx(() => controller.isLoadingOnTopNutritionView.value
                  ? Container()
                  : KategoriGulaWidget(
                      jmlGula:
                          controller.fatsecretTopNutrisiScrap.value!.sugars !=
                                  ""
                              ? double.parse(controller
                                  .fatsecretTopNutrisiScrap.value!.sugars!
                                  .replaceAll('g', '')
                                  .replaceAll(',', '.'))
                              : 0,
                    ))
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Obx(() => controller.isLoadingOnTopNutritionView.value
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SfLinearGauge(
                  minorTicksPerInterval: 4,
                  useRangeColorForAxis: true,
                  animateAxis: true,
                  minimum: 0,
                  maximum: 25,
                  showTicks: false,
                  axisTrackStyle: const LinearAxisTrackStyle(thickness: 1),
                  markerPointers: [
                    LinearShapePointer(
                      value:
                          controller.fatsecretTopNutrisiScrap.value!.sugars !=
                                  ""
                              ? double.parse(controller
                                  .fatsecretTopNutrisiScrap.value!.sugars!
                                  .replaceAll('g', '')
                                  .replaceAll(',', '.'))
                              : 0,
                      height: 20,
                      width: 20,
                      color: AppColors.orange,
                    )
                  ],
                  ranges: const <LinearGaugeRange>[
                    LinearGaugeRange(
                      edgeStyle: LinearEdgeStyle.startCurve,
                      startValue: 0,
                      endValue: 5,
                      position: LinearElementPosition.outside,
                      color: Colors.green,
                      startWidth: 8,
                      endWidth: 8,
                    ),
                    LinearGaugeRange(
                      startValue: 5,
                      endValue: 15,
                      position: LinearElementPosition.outside,
                      color: Colors.yellow,
                      startWidth: 8,
                      endWidth: 8,
                    ),
                    LinearGaugeRange(
                      startValue: 15,
                      endValue: 25,
                      position: LinearElementPosition.outside,
                      edgeStyle: LinearEdgeStyle.endCurve,
                      color: Colors.red,
                      startWidth: 8,
                      endWidth: 8,
                    ),
                  ],
                ),
              )),
      ],
    );
  }
}
