// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/models/fatsecret_product_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:glukofit/views/produk/widgets/card_list_product.dart';

class SearchNutrisiView extends StatelessWidget {
  const SearchNutrisiView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final ProdukController controller = Get.put(ProdukController());

    searchNutrisi(input) {
      controller.getListPencarianNutrisi(input);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            "Cari Nutrisi",
            style: TextStyle(
              color: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55.0,
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[400]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: null,
                                controller: searchController,
                                onEditingComplete: () {},
                                decoration: const InputDecoration.collapsed(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: "Masukkan makanan/minuman",
                                    hoverColor: Colors.transparent,
                                    hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    )),
                                onFieldSubmitted: (e) {
                                  searchNutrisi(e);
                                },
                              ),
                            ),
                            IconButton(
                                // padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  searchNutrisi(searchController.text);
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: AppColors.primary,
                                  size: 25,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                child: Obx(
                  () => controller.isLoading.value
                      ? const SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primary,
                          )))
                      : controller.listPencarianNutrisi.value != null
                          ? ListView.builder(
                              itemCount:
                                  controller.listPencarianNutrisi.value!.length,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                FatsecretProductScrapModel product = controller
                                    .listPencarianNutrisi.value![index];
                                if (index == 0) {
                                  return Container();
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
                            )
                          : Container(
                              padding: const EdgeInsets.only(top: 110),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 250,
                                      width: 250,
                                      child: SvgPicture.asset(
                                          "assets/svg/food-option.svg")),
                                  TextPrimary(
                                    text:
                                        "Hasil Pencarianmu akan muncul disini",
                                    fontSize: 16.0,
                                  )
                                ],
                              ),
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
