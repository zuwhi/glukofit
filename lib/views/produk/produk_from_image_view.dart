import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/controllers/scanner_controller.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class ProdukFromImageView extends StatelessWidget {
  const ProdukFromImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProdukController produkController = Get.put(ProdukController());
    final ScanController controller = Get.find();
    final Map arguments = Get.arguments;
    XFile image = arguments['image'];

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: Image.file(
                              File(image.path),
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                            top: 50,
                            left: 10,
                            child: IconButton(
                                onPressed: () {
                                  // controller.initAll();

                                  Get.offAllNamed(AppRoutes.dashboard);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 35,
                                ))),
                        Positioned(
                            top: MediaQuery.of(context).size.height / 1.78,
                            right: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 500,
                              padding: const EdgeInsets.all(18),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: TextPrimary(
                                      text: "Hasil Scan Gambar",
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextPrimary(
                                              text: "Nama Produk :",
                                              fontSize: 18.0,
                                            ),
                                            TextPrimary(
                                              text: controller
                                                      .resultScan.value.label ??
                                                  '-',
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextPrimary(
                                              text: "Akurasi :",
                                              fontSize: 18.0,
                                            ),
                                            TextPrimary(
                                              text:
                                                  "${(controller.resultScan.value.confidence! * 100).round()}%",
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 29.0,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          child: RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 13),
                                              children: <InlineSpan>[
                                                const TextSpan(
                                                  text:
                                                      'Jika Hasil Tidak sesuai lakukan pencarian dengan klik di samping ini ', // Teks biasa
                                                ),
                                                const WidgetSpan(
                                                  child: Icon(Icons.search,
                                                      size: 13,
                                                      color: Colors.blue),
                                                ),
                                                TextSpan(
                                                  text:
                                                      'pencarian', // Teks yang bisa diklik
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Get.toNamed(AppRoutes
                                                              .searchNutrisi);
                                                        },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 80.0,
                                        ),
                                        ButtonPrimary(
                                            text: "Lihat Nutrisi",
                                            isActive: true,
                                            backgroundColor: AppColors.orange,
                                            onPressed: () {
                                              List<ProdukModel> produkList =
                                                  produkController.listProduk
                                                      .where((produk) => produk
                                                          .nama_produk
                                                          .toLowerCase()
                                                          .contains(controller
                                                              .resultScan
                                                              .value
                                                              .label!
                                                              .toLowerCase()))
                                                      .toList();
                                              Get.toNamed(
                                                  AppRoutes.detailProduk,
                                                  arguments: {
                                                    "produkArgs": produkList[0]
                                                  });
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
