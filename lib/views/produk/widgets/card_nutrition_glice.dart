import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:glukofit/views/produk/nutrisi_produk_view.dart';
import 'package:glukofit/views/produk/widgets/card_point_nutrition.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CardNutritionGlaceWidget extends StatelessWidget {
  const CardNutritionGlaceWidget({
    super.key,
    required this.controller,
  });

  final ProdukController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.isLoadingOnNutritionView.value
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardPointNutrition(
                      title: "Gula",
                      value:
                          controller.fatsecretNutrisiScrap.value!.sugars ?? '0',
                      image: "gula.png",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CardPointNutrition(
                      title: "Kalori",
                      value:
                          controller.fatsecretNutrisiScrap.value!.energyKcal ??
                              "0",
                      image: "energi.png",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CardPointNutrition(
                      title: "Protein",
                      value: controller.fatsecretNutrisiScrap.value!.protein ??
                          "0",
                      image: "protein.png",
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CardPointNutrition(
                      title: "Lemak",
                      value: controller.fatsecretNutrisiScrap.value!.fat ?? '0',
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
              Obx(() => controller.isLoadingOnNutritionView.value
                  ? Container()
                  : KategoriGulaWidget(
                      jmlGula:
                          controller.fatsecretNutrisiScrap.value!.sugars != ""
                              ? double.parse(controller
                                  .fatsecretNutrisiScrap.value!.sugars!
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
        Obx(() => controller.isLoadingOnNutritionView.value
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
                          controller.fatsecretNutrisiScrap.value!.sugars != ""
                              ? double.parse(controller
                                  .fatsecretNutrisiScrap.value!.sugars!
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
