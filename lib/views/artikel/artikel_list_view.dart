import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/views/artikel/artikel_detail_view.dart';
import 'package:glukofit/views/artikel/widgets/card.dart';

class ArtikelListView extends GetView<ArtikelController> {
  const ArtikelListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToDetailPage(ArtikelModel artikel) {
      Get.to(() => ArtikelDetailView(artikel: artikel));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel'),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: GetBuilder<ArtikelController>(
              builder: (_) {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: controller.filteredArtikels.length,
                    itemBuilder: (context, index) {
                      final artikel = controller.filteredArtikels[index];
                      return ArtikelCard(
                        artikel: artikel,
                        onTap: () => navigateToDetailPage(artikel),
                      );
                    },
                  ),
                );
              },
            ),
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
            // Gunakan ChoiceChip alih-alih FilterChip
            label: Text(label),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                controller.setSelectedKategori(kategori);
              }
            },
            selectedColor: Colors.blue,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
}
