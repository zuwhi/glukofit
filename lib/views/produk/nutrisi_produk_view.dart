// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/models/fatsecret_product_model.dart';
import 'package:glukofit/models/tracker_model.dart';
import 'package:glukofit/views/global_widgets/bottom_sheet_add_nutrition_widget.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:glukofit/views/produk/widgets/card_nutrition_glice.dart';
import 'package:glukofit/views/produk/widgets/card_nutrition_label_widget.dart';

class NutrisiProdukView extends StatelessWidget {
  const NutrisiProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    FatsecretProductScrapModel product = arguments['product'];

    // FatsecretProductScrapModel product = FatsecretProductScrapModel(
    //     brandName: "coca cola", portionInfo: "a", productName: "coca coLA");

    // FatsecretNutrisiScrapModel nutrisi = FatsecretNutrisiScrapModel(
    //   sugars: "10",
    //   carbs: "0",
    //   servingSize: "100",
    //   fat: "0",
    //   saturatedFat: "0",
    //   sodium: "0",
    //   protein: "0",
    //   energyKcal: "0",
    //   energyKj: "0",
    // );
    final ProdukController controller = Get.put(ProdukController());

    controller.getNutritionProductFromFatsecretScrap(product.link!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              final TrackerModel tracker = TrackerModel(
                  id: '0',
                  keterangan: "konsumsi ${product.productName}",
                  kalori: int.parse(controller
                      .fatsecretNutrisiScrap.value!.energyKcal!
                      .replaceAll(" kkal", "")),
                  gula: controller.fatsecretNutrisiScrap.value!.sugars != null
                      ? controller
                              .fatsecretNutrisiScrap.value!.sugars!.isNotEmpty
                          ? double.parse(controller
                              .fatsecretNutrisiScrap.value!.sugars!
                              .replaceAll("g", "")
                              .replaceAll(",", "."))
                          : 0.0
                      : 0.0);

              Get.bottomSheet(BottomSheetAddNutritionWidget(
                trackFromEdit: tracker,
                isFromSearch: true,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Row(
                children: [
                  TextPrimary(
                    text: "Simpan kalori",
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.orange,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Icon(
                    Icons.add,
                    color: AppColors.orange,
                  ),
                  const SizedBox(
                    width: 7.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextPrimary(
                        text: product.productName ?? "",
                        fontWeight: FontWeight.w700,
                        fontSize: 26.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    TextPrimary(
                      text: product.brandName ?? "",
                      fontWeight: FontWeight.w400,
                      fontSize: 23.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                TextPrimary(
                  text: "Nutrisi Sekilas :",
                  fontSize: 18.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CardNutritionGlaceWidget(controller: controller),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(() => controller.isLoadingOnNutritionView.value
                    ? const SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primary,
                        )))
                    : CardNutritionLabelWidget(
                        nutrisi: controller.fatsecretNutrisiScrap.value!))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KategoriGulaWidget extends StatelessWidget {
  const KategoriGulaWidget({super.key, required this.jmlGula});

  final double jmlGula;

  @override
  Widget build(BuildContext context) {
    String kategori = '';
    Color warna = Colors.white;
    if (jmlGula <= 5) {
      kategori = 'Rendah';
      warna = Colors.green;
    } else if (jmlGula <= 15) {
      kategori = "Sedang";
      warna = Colors.yellow;
    } else if (jmlGula >= 15) {
      kategori = "Tinggi";
      warna = Colors.red;
    }

    return Container(
      child: TextPrimary(
        text: kategori,
        color: warna,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
