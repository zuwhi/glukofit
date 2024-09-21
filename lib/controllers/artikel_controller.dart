import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'dart:typed_data';
import 'package:glukofit/services/appwrite_service.dart';
import 'package:image_picker/image_picker.dart';

class ArtikelController extends GetxController {
  final AppwriteService artikelService = Get.find<AppwriteService>();
  final RxList<ArtikelModel> artikels = <ArtikelModel>[].obs;
  final RxList<ArtikelModel> filteredArtikels = <ArtikelModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxList<String> kategoris = <String>[].obs;
  final RxString selectedKategori = 'Semua'.obs;
  final searchController = TextEditingController();
  final Map<String, Uint8List> imageCache = {};
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  late QuillController quillController;
  final Rx<XFile?> image = Rx<XFile?>(null);
  final RxBool isEditing = false.obs;
  final RxString editingArtikelId = ''.obs;
  final RxString currentImageId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    quillController = QuillController.basic();
    Future.delayed(Duration.zero, () {
      fetchArtikels();
    });
    ever(selectedKategori, (_) => _applyFilter());
    filteredArtikels.assignAll(artikels);
  }

  @override
  void onClose() {
    searchController.dispose();
    titleController.dispose();
    dateController.dispose();
    quillController.dispose();
    super.onClose();
  }

  void resetFields() {
    titleController.clear();
    dateController.clear();
    quillController = QuillController.basic();
    selectedKategori.value = 'Semua';
    image.value = null;
    isEditing.value = false;
    editingArtikelId.value = '';
    currentImageId.value = '';
  }

  Future<void> addArtikel() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      String imageId = '';
      if (image.value != null) {
        imageId = await artikelService.uploadArtikelImage(
          File(image.value!.path),
          image.value!.name,
        );
      }

      final newArtikel = ArtikelModel(
        id: '',
        tanggal: dateController.text,
        imageId: imageId,
        kategori: selectedKategori.value,
        judul: titleController.text,
        deskripsi: jsonEncode(quillController.document.toDelta().toJson()),
      );
      await artikelService.addArtikel(newArtikel);
      await fetchArtikels();
      resetFields();
      Get.back();
      Get.snackbar('Sukses', 'Artikel berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan artikel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateArtikel() async {
    if (!validateForm()) return;

    isLoading.value = true;
    try {
      String imageId = currentImageId.value;
      if (image.value != null && image.value!.path != currentImageId.value) {
        if (currentImageId.value.isNotEmpty) {
          await artikelService.deleteArtikelImage(currentImageId.value);
        }
        imageId = await artikelService.uploadArtikelImage(
          File(image.value!.path),
          image.value!.name,
        );
      }

      final updatedArtikel = ArtikelModel(
        id: editingArtikelId.value,
        tanggal: dateController.text,
        imageId: imageId,
        kategori: selectedKategori.value,
        judul: titleController.text,
        deskripsi: jsonEncode(quillController.document.toDelta().toJson()),
      );

      await artikelService.updateArtikel(updatedArtikel);
      await fetchArtikels();
      resetFields();
      Get.back();
      Get.snackbar('Sukses', 'Artikel berhasil diperbarui');
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui artikel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadArtikelForEdit(ArtikelModel artikel) {
    isEditing.value = true;
    editingArtikelId.value = artikel.id;
    titleController.text = artikel.judul;
    dateController.text = artikel.tanggal;
    selectedKategori.value = artikel.kategori;

    List<dynamic> deskripsiJson;
    try {
      deskripsiJson = jsonDecode(artikel.deskripsi);
    } catch (e) {
      final convertedDeskripsi = jsonEncode([
        {"insert": "${artikel.deskripsi}\n"}
      ]);
      deskripsiJson = jsonDecode(convertedDeskripsi);
    }

    quillController = QuillController(
      document: Document.fromJson(deskripsiJson),
      selection: const TextSelection.collapsed(offset: 0),
    );

    currentImageId.value = artikel.imageId;
    image.value = null;
  }

  Future<void> deleteArtikel(String id, String imageId) async {
    isLoading.value = true;
    try {
      await artikelService.deleteArtikel(id);
      if (imageId.isNotEmpty) {
        await artikelService.deleteArtikelImage(imageId);
      }
      await fetchArtikels();
      Get.snackbar('Sukses', 'Artikel berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus artikel: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchArtikels() async {
    isLoading.value = true;
    try {
      final documents = await artikelService.getAllArtikel();
      artikels.value = documents
          .map((doc) => ArtikelModel.fromMap(doc.data))
          .toList()
          .reversed
          .toList();
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
    return artikels.first;
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

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage;
    }
  }

  bool validateForm() {
    if (titleController.text.isEmpty) {
      Get.snackbar('Error', 'Judul tidak boleh kosong');
      return false;
    }
    if (!isEditing.value) {
      if (image.value == null) {
        Get.snackbar('Error', 'Silakan pilih gambar');
        return false;
      }
    }
    if (dateController.text.isEmpty) {
      Get.snackbar('Error', 'Tanggal tidak boleh kosong');
      return false;
    }
    return true;
  }

  void submitForm() async {
    if (validateForm()) {
      isLoading.value = true;
      try {
        if (isEditing.value) {
          await updateArtikel();
        } else {
          await addArtikel();
        }
      } catch (e) {
        Get.snackbar('Error',
            'Gagal ${isEditing.value ? 'memperbarui' : 'menyimpan'} artikel: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
