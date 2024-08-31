import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/views/artikel/artikel_detail_view.dart';
import 'package:glukofit/views/artikel/widgets/card.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtikelListView extends GetView<ArtikelController> {
  const ArtikelListView({super.key});

  void navigateToDetailPage(ArtikelModel artikel) {
    Get.to(() => ArtikelDetailView(artikel: artikel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artikel',
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (value) => controller.filterArtikels(value),
                    decoration: InputDecoration(
                      hintText: 'Find Article',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/icons/search.png',
                          height: 8,
                          width: 8,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    cursorColor: AppColors.primary,
                  ),
                ),
                _buildCategoryFilter(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Top Article',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildTopArticle(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'For You',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<ArtikelController>(
            builder: (_) {
              if (controller.isLoading.value) {
                return const SliverFillRemaining(
                  child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary)),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.only(
                    top: 8, left: 24, right: 24, bottom: 16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    final artikel = controller.filteredArtikels[index];
                    return ArtikelCard(
                      artikel: artikel,
                      onTap: () => navigateToDetailPage(artikel),
                      isLarge: index % 3 == 0,
                    );
                  },
                  childCount: controller.filteredArtikels.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return GetBuilder<ArtikelController>(
      builder: (_) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const SizedBox(width: 20),
              _buildFilterChip('Semua', 'Semua'),
              _buildFilterChip('Seputar Diabetes', 'Seputar Diabetes'),
              _buildFilterChip('Nutrisi', 'Nutrisi'),
              _buildFilterChip('Resep Makanan', 'Resep Makanan'),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String kategori) {
    return GetBuilder<ArtikelController>(
      builder: (_) {
        final bool isSelected = controller.selectedKategori.value == kategori;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ChoiceChip(
            showCheckmark: false,
            label: Text(label),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                controller.setSelectedKategori(kategori);
              }
            },
            backgroundColor: AppColors.primary,
            selectedColor: AppColors.orange,
            labelStyle: GoogleFonts.dmSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopArticle() {
    return GetBuilder<ArtikelController>(
      builder: (_) {
        final artikel = controller.getLatestArtikel();

        if (artikel == null) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () => navigateToDetailPage(artikel),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 180,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: GetBuilder<ArtikelController>(
                    builder: (controller) {
                      final cachedImage =
                          controller.imageCache[artikel.imageId];

                      if (cachedImage != null) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          clipBehavior: Clip.antiAlias,
                          child: Image.memory(
                            cachedImage,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return FutureBuilder<Uint8List?>(
                          future: controller.getArtikelImage(artikel.imageId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.primary));
                            }
                            if (snapshot.hasData) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                clipBehavior: Clip.antiAlias,
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
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: AppColors.primary),
                  child: Text(
                    artikel.judul,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
