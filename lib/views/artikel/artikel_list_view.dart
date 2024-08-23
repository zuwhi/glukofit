import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        backgroundColor: Colors.blue,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    // controller: controller.searchController,
                    // onChanged: (value) => controller.filterArtikels(value),
                    decoration: InputDecoration(
                      hintText: 'Find Article',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/icons/search.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 12.0),
                    ),
                  ),
                  _buildCategoryFilter(),
                  const SizedBox(height: 20),
                  Text(
                    'Top Article',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTopArticle(),
                  Text(
                    'For You',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<ArtikelController>(
              builder: (_) {
                if (controller.isLoading.value) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final artikel = controller.filteredArtikels[index];
                      return ArtikelCard(
                        artikel: artikel,
                        onTap: () => navigateToDetailPage(artikel),
                      );
                    },
                    childCount: controller.filteredArtikels.length,
                  ),
                );
              },
            ),
          ],
        ),
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
              _buildFilterChip('Semua', 'Semua'),
              _buildFilterChip('Seputar Diabetes', 'Seputar Diabetes'),
              _buildFilterChip('Nutrisi', 'Nutrisi'),
              _buildFilterChip('Resep Makanan', 'Resep Makanan'),
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
            backgroundColor: const Color(0xFF48ACA2),
            selectedColor: const Color(0xFFFF6601),
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
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: GetBuilder<ArtikelController>(
                    builder: (controller) {
                      return FutureBuilder<Uint8List?>(
                        future: controller.getArtikelImage(artikel.imageId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
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
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.green),
                  child: Text(
                    artikel.judul,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
