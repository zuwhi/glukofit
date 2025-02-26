// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/controllers/scanner_controller.dart';
import 'package:glukofit/models/fatsecret_product_model.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:glukofit/views/produk/widgets/card_list_product.dart';
import 'package:glukofit/views/produk/widgets/card_top_nutrition_glice.dart';


class ProdukView extends StatelessWidget {
  const ProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    ProdukModel produk = arguments['produkArgs'];

    // ProdukModel produk = ProdukModel(
    //     id: '1',
    //     nama_produk: "coca-cola",
    //     image:
    //         "https://images.tokopedia.net/img/cache/700/product-1/2019/7/20/71160237/71160237_bbcb12c4-845f-4c98-bdb7-c0b7817fceb6_540_540",
    //     desc: null);

    final ProdukController controller = Get.put(ProdukController());
    final ScanController scanController = Get.put(ScanController());

    controller.getListProductFromFatsecretScrap(produk.nama_produk);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: const Text(
              "hasil scan",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.dashboard);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                color: AppColors.primary,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsetsDirectional.only(start: 15),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: CachedNetworkImage(
                              imageUrl: produk.image,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ))),
                        const SizedBox(
                          width: 20.0,
                        ),
                        TextPrimary(
                          text: produk.nama_produk,
                          fontSize: 33.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF615D5E),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    produk.desc != null
                        ? Text(produk.desc ?? "not found")
                        : Obx(() => controller.isLoading.value
                            ? const SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                )))
                            : ListView.builder(
                                itemCount: controller
                                    .listFatscretProductScrap.value!.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  FatsecretProductScrapModel product =
                                      controller.listFatscretProductScrap
                                          .value![index];
                                  if (index == 0) {
                                    return Container();
                                  } else if (index == 1) {
                                    controller
                                        .getTopNutritionProductFromFatsecretScrap(
                                            product.link!);
                                    return Obx(() => controller
                                            .isLoadingOnTopNutritionView.value
                                        ? const SizedBox(
                                            height: 100,
                                            width: double.infinity,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextPrimary(
                                                    text: "Ukuran Porsi :",
                                                    fontSize: 18.0,
                                                  ),
                                                  TextPrimary(
                                                    text: controller
                                                            .fatsecretTopNutrisiScrap
                                                            .value!
                                                            .servingSize ??
                                                        '',
                                                    fontSize: 18.0,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoutes.nutrisiProduk,
                                                      arguments: {
                                                        "product": product
                                                      });
                                                },
                                                child:
                                                    CardTopNutritionGlaceWidget(
                                                        controller: controller),
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              TextPrimary(
                                                text: "Produk Terkait :",
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                            ],
                                          ));
                                  } else {
                                    return CardListProductWidget(
                                      product: product,
                                      onTap: () {
             
                                        Get.toNamed(AppRoutes.nutrisiProduk,
                                            arguments: {"product": product});
                                      },
                                    );
                                  }
                                },
                              ))
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
