import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'dart:typed_data';
import 'package:glukofit/services/appwrite_service.dart';

class ArtikelController extends GetxController {
  final AppwriteService artikelService = Get.find<AppwriteService>();
  final RxList<ArtikelModel> artikels = <ArtikelModel>[].obs;
  final RxList<ArtikelModel> filteredArtikels = <ArtikelModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxList<String> kategoris = <String>[].obs;
  final RxString selectedKategori = 'Semua'.obs;
  final searchController = TextEditingController();
  final Map<String, Uint8List> imageCache = {};
  

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      fetchArtikels();
    });
    ever(selectedKategori, (_) => _applyFilter());
    filteredArtikels.assignAll(artikels);
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchArtikels() async {
    isLoading.value = true;
    try {
      final documents = await artikelService.getAllArtikel();
      artikels.value =
          documents.map((doc) => ArtikelModel.fromMap(doc.data)).toList();
      filteredArtikels.value = artikels;
      kategoris.value = [
        'Semua',
        'Seputar Diabetes',
        'Nutrisi',
        'Resep Makanan'
      ];
    } catch (e) {
      print('Error fetching artikels: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<Uint8List?> getArtikelImage(String imageId) async {
    if (imageCache.containsKey(imageId)) {
      return imageCache[imageId];
    }

    final imageData = await artikelService.getArtikelImage(imageId);
    if (imageData != null) {
      imageCache[imageId] = imageData;
    }
    return imageData;
  }

  ArtikelModel? getLatestArtikel() {
    if (artikels.isEmpty) {
      return null;
    }
    return artikels.last;
  }

  void setSelectedKategori(String kategori) {
    selectedKategori.value = kategori;
    _applyFilter();
  }

  void _applyFilter() {
    String searchQuery = searchController.text.toLowerCase();
    if (selectedKategori.value == 'Semua') {
      filteredArtikels.value = artikels
          .where((artikel) =>
              artikel.judul.toLowerCase().contains(searchQuery) ||
              artikel.kategori.toLowerCase().contains(searchQuery))
          .toList();
    } else {
      filteredArtikels.value = artikels
          .where((artikel) =>
              artikel.kategori == selectedKategori.value &&
              (artikel.judul.toLowerCase().contains(searchQuery)))
          .toList();
    }
    update();
  }

  void filterArtikels(String query) {
    if (query.isEmpty) {
      _applyFilter();
    } else {
      filteredArtikels.value = artikels
          .where((artikel) =>
              artikel.judul.toLowerCase().contains(query.toLowerCase()) ||
              artikel.kategori.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }
}
