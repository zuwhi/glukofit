import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/produk_controller.dart';
import 'package:glukofit/controllers/scanner_controller.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    ProdukController produkController = Get.put(ProdukController());
    final ScanController scanController = Get.put(ScanController());
    scanController.initAll();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (produkController.listProduk.isEmpty &&
              !produkController.isLoaded.value) {
            produkController.getListProduk();
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          {
            return SafeArea(
              child: Stack(
                children: [
                  // Text(produkController.listProduk[1].nama_produk),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GetBuilder<ScanController>(
                      init: ScanController(),
                      builder: (controller) {
                        if (controller.isCamerainitialized.value &&
                            controller.cameraController.value.isInitialized) {
                          return CameraPreview(controller.cameraController);
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.primary,
                            )),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.35,
                    child: Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.3,
                            child:
                                SvgPicture.asset("assets/images/gridbox.svg"))),
                  ),
                  Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  scanController.stopCamera();
                                  Get.offAllNamed(AppRoutes.dashboard);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                            const Text(
                              "scan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              width: 30.0,
                            ),
                          ],
                        ),
                      )),
                  // Positioned(
                  //   bottom: 0,
                  //   left: 0,
                  //   right: 0,
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         color: Colors.black38,
                  //         width: double.infinity,
                  //         height: 105,
                  //         padding: const EdgeInsets.symmetric(horizontal: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             // SizedBox(
                  //             //   width: 35,
                  //             //   child: IconButton(
                  //             //       onPressed: () {},
                  //             //       icon: const Icon(
                  //             //         Icons.photo,
                  //             //         size: 35,
                  //             //         color: Colors.white,
                  //             //       )),
                  //             // ),
                  //             InkWell(
                  //               onTap: () {
                  //                 scanController.captureImage();
                  //               },
                  //               child: Container(
                  //                 margin: const EdgeInsets.all(20),
                  //                 padding: const EdgeInsets.all(5),
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(100),
                  //                     border: Border.all(
                  //                         width: 2, color: Colors.white)),
                  //                 child: Container(
                  //                   width: 50,
                  //                   height: 50,
                  //                   decoration: const BoxDecoration(
                  //                     color: Colors.white, // border color
                  //                     shape: BoxShape.circle,
                  //                   ),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(2),
                  //                     child: Container(
                  //                       decoration: const BoxDecoration(
                  //                         shape: BoxShape.circle,
                  //                         color: Colors.transparent,
                  //                       ),
                  //                       child: Container(),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             // const SizedBox(
                  //             //   width: 35,
                  //             // )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  scanController.resultScan.value.confidence != 0 &&
                          scanController.resultScan.value.confidence! * 100 >=
                              80
                      ? Positioned(
                          bottom: 110,
                          left: 0,
                          right: 0,
                          child: CardProduk(
                              namaProduk:
                                  scanController.resultScan.value.label ?? "",
                              produkController: produkController,
                              scanController: scanController),
                        )
                      : Container()
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

class CardProduk extends StatelessWidget {
  const CardProduk({
    super.key,
    required this.namaProduk,
    required this.produkController,
    required this.scanController,
  });

  final String namaProduk;
  final ProdukController produkController;
  final ScanController scanController;

  @override
  Widget build(BuildContext context) {
    if (namaProduk != "") {
      List<ProdukModel> produkList = produkController.listProduk
          .where((produk) => produk.nama_produk
              .toLowerCase()
              .contains(namaProduk.toLowerCase()))
          .toList();

      if (produkList.isNotEmpty) {
        ProdukModel produk = produkList[0];
        return Center(
          child: InkWell(
            onTap: () {
              Get.find<ScanController>().stopCamera();
              Get.toNamed(AppRoutes.detailProduk,
                  arguments: {'produkArgs': produk});
            },
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 300.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.black.withOpacity(0.5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 50,
                            height: 50,
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
                        TextPrimary(
                          text: produk.nama_produk,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                        Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsetsDirectional.only(
                              end: 15,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            )),
                      ]),
                ),
              ),
            ),
          ),
        );
      } else {
        // Menangani kasus ketika produkList kosong
        return Container();
      }
    } else {
      return Container();
    }
  }
}
