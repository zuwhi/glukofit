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

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      fetchArtikels();
    });
    ever(selectedKategori, (_) => _applyFilter());
    super.onInit();
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
    return await artikelService.getArtikelImage(imageId);
  }

  void setSelectedKategori(String kategori) {
    selectedKategori.value = kategori;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedKategori.value == 'Semua') {
      filteredArtikels.value = artikels;
    } else {
      filteredArtikels.value = artikels
          .where((artikel) => artikel.kategori == selectedKategori.value)
          .toList();
    }
    update();
  }
}
