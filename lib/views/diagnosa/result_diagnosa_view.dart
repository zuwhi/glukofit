// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';

class ResultDiagnosaView extends StatelessWidget {
  const ResultDiagnosaView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    String diagnosa = arguments['diagnosa'];
    return Scaffold(
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
              Get.back();
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
              SvgPicture.asset("assets/images/doctor_result.svg"),
              TextPrimary(
                text:
                    "Dari data yang anda masukkan Sistem mediagnosa anda memiliki risiko:",
                fontSize: 18.0,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextPrimary(
                text: "$diagnosa Diabetes",
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
              const SizedBox(
                height: 80.0,
              ),
              SizedBox(
                width: 340,
                child: TextPrimary(
                    textAlign: TextAlign.justify,
                    color: Colors.grey[600],
                    text:
                        "*NB : Perlu diketahui bahwasannya fitur ini merupakan diagnosa awal dan bukan menjadi acuan utama, jika ingin mendapatkan keterangan lebih lanjut mohon melakukan konsultasi medis dengan tenaga kesehatan secara langsung ."),
              )
            ],
          ),
        ),
      ),
    );
  }
}
