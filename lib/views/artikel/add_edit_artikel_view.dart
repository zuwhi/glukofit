import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:intl/intl.dart';

class AddEditArtikelView extends GetView<ArtikelController> {
  const AddEditArtikelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.isEditing.value ? 'Edit Artikel' : 'Tambah Artikel',
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
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
            controller.resetFields();
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: controller.image.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(controller.image.value!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : (controller.currentImageId.value.isNotEmpty ||
                                controller.currentImageId.value != '')
                            ? FutureBuilder<Uint8List?>(
                                future: controller.getArtikelImage(
                                    controller.currentImageId.value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.data != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else {
                                    return Icon(Icons.image,
                                        size: 50, color: Colors.grey[400]);
                                  }
                                },
                              )
                            : Icon(Icons.image,
                                size: 50, color: Colors.grey[400]),
                  )),
              const SizedBox(height: 16),
              SizedBox(
                child: ElevatedButton(
                  onPressed: controller.pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add_photo_alternate,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      TextPrimary(
                        text: 'Ubah Gambar',
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.dateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('d MMMM yyyy', 'id_ID').format(pickedDate);
                    controller.dateController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                  value: controller.selectedKategori.value == 'Semua'
                      ? controller.kategoris.firstWhere((k) => k != 'Semua',
                          orElse: () => controller.kategoris.first)
                      : controller.selectedKategori.value,
                  items: controller.kategoris
                      .where((category) => category != 'Semua')
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: TextPrimary(text: category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedKategori.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: TextPrimary(
                  text: "Deskripsi",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              quill.QuillSimpleToolbar(
                controller: controller.quillController,
                configurations: const quill.QuillSimpleToolbarConfigurations(
                  showAlignmentButtons: false,
                  // showColorButton: false,
                  showBackgroundColorButton: false,
                  showCodeBlock: false,
                  showHeaderStyle: false,
                  // showDirection: false,
                  // showListBullets: false,
                  showFontFamily: false,
                  showSearchButton: false,
                  // showLink: false,
                  showListCheck: false,
                  showDividers: false,
                  // showListNumbers: false,
                  showSuperscript: false,
                  showClearFormat: false,
                  showQuote: false,
                  showUnderLineButton: false,
                  showIndent: false,
                  showStrikeThrough: false,
                  showSubscript: false,
                  showInlineCode: false,
                  // showFontSize: false
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: quill.QuillEditor(
                  controller: controller.quillController,
                  scrollController: ScrollController(keepScrollOffset: false),
                  focusNode: FocusNode(),
                  configurations: const quill.QuillEditorConfigurations(
                    placeholder: 'Tambahkan Konten',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => controller.isLoading.value
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : ButtonPrimary(
                      onPressed: controller.submitForm,
                      text: controller.isEditing.value
                          ? 'Perbarui Artikel'
                          : 'Tambah Artikel',
                      isActive: true,
                      backgroundColor: AppColors.primary,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
