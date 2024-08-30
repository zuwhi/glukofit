// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/diagnosa_controller.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class ResultDiagnosaView extends StatelessWidget {
  const ResultDiagnosaView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    String diagnosa = arguments['diagnosa'];
    final DiagnosaController controller = Get.find();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextPrimary(
            text: 'Hasil Diagnosa',
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: IconButton(
              onPressed: () {
                controller.currentIndex.value = 1;
                Get.offAllNamed(AppRoutes.diagnosa);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Image.asset("assets/images/diagnosis.png"),
                TextPrimary(
                  text:
                      "Dari data yang anda masukkan Sistem mediagnosa anda memiliki risiko:",
                  fontSize: 18.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 60.0,
                ),
                TextPrimary(
                  text: "$diagnosa Diabetes",
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange,
                ),
                const SizedBox(
                  height: 60.0,
                ),
                SizedBox(
                  width: 340,
                  child: TextPrimary(
                      textAlign: TextAlign.justify,
                      fontSize: 13.0,
                      color: Colors.grey[500],
                      text:
                          "*NB : Perlu diketahui bahwasannya fitur ini merupakan diagnosa awal dan bukan menjadi acuan utama, jika ingin mendapatkan keterangan lebih lanjut mohon melakukan konsultasi medis dengan tenaga kesehatan secara langsung ."),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
