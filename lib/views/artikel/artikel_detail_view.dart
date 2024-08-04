import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/controllers/artikel_controller.dart';

class ArtikelDetailView extends GetView<ArtikelController> {
  final ArtikelModel artikel;

  const ArtikelDetailView({super.key, required this.artikel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Artikel'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Uint8List?>(
              future: controller.getArtikelImage(artikel.imageId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                }
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              artikel.judul,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Kategori: ${artikel.kategori}',
            ),
            Text(
              artikel.tanggal,
            ),
            const SizedBox(height: 16),
            Text(
              artikel.deskripsi,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
