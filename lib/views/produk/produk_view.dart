// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class ProdukView extends StatelessWidget {
  const ProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;

    ProdukModel produk = arguments['produkArgs'];
    // ProdukModel produk = ProdukModel(
    //     id: '1',
    //     nama_produk: "coca coala",
    //     kadar_gula: 50,
    //     image:
    //         "https://images.tokopedia.net/img/cache/700/product-1/2019/7/20/71160237/71160237_bbcb12c4-845f-4c98-bdb7-c0b7817fceb6_540_540",
    //     desc: "coca cola adalah bakl;mdkbjhv hvvde chsc  aS  saf gf ");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            "scan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
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
              padding: const EdgeInsets.all(25.0),
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
                  Container(
                    width: double.infinity,
                    height: 120,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.primary, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextPrimary(
                          text: "Kadar gula :",
                          fontSize: 25.0,
                        ),
                        const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xFFD9D9D9),
                            strokeWidth: 5,
                            value: 0.8,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextPrimary(
                    text: "Deskripsi :",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  TextPrimary(
                    text: produk.desc,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF615D5E),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
