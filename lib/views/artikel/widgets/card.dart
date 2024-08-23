import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/models/artikel_model.dart';

class ArtikelCard extends StatelessWidget {
  final ArtikelModel artikel;
  final VoidCallback onTap;

  const ArtikelCard({super.key, required this.artikel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: GetBuilder<ArtikelController>(
                builder: (controller) {
                  return FutureBuilder<Uint8List?>(
                    future: controller.getArtikelImage(artikel.imageId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.memory(
                            snapshot.data!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return Container(
                        color: Colors.grey,
                        child: const Icon(Icons.error),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.green),
              child: Text(
                artikel.judul,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
