import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtikelDetailView extends GetView<ArtikelController> {
  final ArtikelModel artikel;

  const ArtikelDetailView({super.key, required this.artikel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Artikel',
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            width: 12,
            height: 26,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Uint8List?>(
              future: controller.getArtikelImage(artikel.imageId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    child: Image.memory(
                      snapshot.data!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.access_time_outlined,
                  size: 12,
                  color: Color(0xFFA6A4A4),
                ),
                const SizedBox(width: 5),
                Text(
                  artikel.tanggal,
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFA6A4A4)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              artikel.judul,
              style:
                  GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: IconButton(
            //     icon: const Icon(
            //       Icons.comment,
            //       size: 30,
            //       color: Color(0xFFA6A4A4),
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
            Text(
              artikel.deskripsi,
              textAlign: TextAlign.justify,
              style:
                  GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
