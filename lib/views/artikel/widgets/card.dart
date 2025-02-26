import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtikelCard extends StatelessWidget {
  final ArtikelModel artikel;
  final VoidCallback onTap;
  final bool isLarge;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ArtikelCard({
    super.key,
    required this.artikel,
    required this.onTap,
    this.isLarge = false,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: isLarge ? 150 : 100,
            child: GetBuilder<ArtikelController>(
              builder: (controller) {
                final cachedImage = controller.imageCache[artikel.imageId];
                if (cachedImage != null) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.memory(
                      cachedImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                } else {
                  return FutureBuilder<Uint8List?>(
                    future: controller.getArtikelImage(artikel.imageId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary));
                      }
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      }
                      return Container(
                        color: Colors.grey,
                        child: const Icon(Icons.error),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text(
              artikel.judul,
              style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onEdit != null || onDelete != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: onEdit,
                    color: Colors.white,
                    style: IconButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10)),
                  ),

                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, size: 18),
                    onPressed: onDelete,
                    color: Colors.white,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10)),
                  ),
                // ElevatedButton.icon(
                //   onPressed: onDelete,
                //   icon: const Icon(Icons.delete, size: 18),
                //   label: const Text(''),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.red,
                //     foregroundColor: Colors.white,
                //     // padding: const EdgeInsets.symmetric(
                //     //     horizontal: 8, vertical: 4),
                //   ),
                // ),
              ],
            ),
        ],
      ),
    );
  }
}
