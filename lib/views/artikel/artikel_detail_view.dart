import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/comment_controller.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/models/comment_model.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ArtikelDetailView extends GetView<ArtikelController> {
  final ArtikelModel artikel;

  ArtikelDetailView({super.key, required this.artikel}) {
    Get.put(CommentController());
    Get.find<CommentController>().getCommentsByArtikel(artikel.id);
  }
  @override
  Widget build(BuildContext context) {
    final commentController = Get.find<CommentController>();
    final authController = Get.find<AuthController>();

    List<dynamic> deskripsiJson;
    try {
      deskripsiJson = jsonDecode(artikel.deskripsi);
    } catch (e) {
      final convertedDeskripsi = jsonEncode([
        {"insert": "${artikel.deskripsi}\n"}
      ]);
      deskripsiJson = jsonDecode(convertedDeskripsi);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Artikel',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Uint8List?>(
              future: controller.getArtikelImage(artikel.imageId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    child: Image.memory(
                      snapshot.data!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return const SizedBox(
                  height: 200,
                  child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary)),
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.access_time_outlined,
                  size: 12,
                  color: Color(0xFFA6A4A4),
                ),
                const SizedBox(width: 5),
                Text(
                  artikel.tanggal,
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFA6A4A4)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 16),
            Text(
              artikel.judul,
              style:
                  GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            // Text(
            //   artikel.deskripsi,
            //   textAlign: TextAlign.justify,
            //   style:
            //       GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500),
            // ),
            QuillEditor.basic(
                controller: QuillController(
                  document: Document.fromJson(deskripsiJson),
                  selection: const TextSelection.collapsed(offset: 0),
                  readOnly: true,
                ),
                configurations: QuillEditorConfigurations(
                    autoFocus: false,
                    showCursor: false,
                    customStyles: DefaultStyles(
                      paragraph: DefaultTextBlockStyle(
                          GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          const HorizontalSpacing(0, 0),
                          const VerticalSpacing(2, 2),
                          const VerticalSpacing(2, 2),
                          null),
                    ))),
            const SizedBox(height: 24),
            Text(
              'Komentar',
              style:
                  GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Obx(
              () => commentController.isLoading.value
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return FutureBuilder<Map<String, dynamic>>(
                          future: authController.getUserData(comment.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final userData = snapshot.data ?? {};
                              return CommentItem(
                                comment: comment,
                                userName: userData['nama'] ?? 'Unknown User',
                                userImageId: userData['imageId'],
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ));
                          },
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            CommentForm(artikelId: artikel.id),
          ],
        ),
      ),
      extendBody: true,
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final String userName;
  final String? userImageId;

  const CommentItem({
    super.key,
    required this.comment,
    required this.userName,
    this.userImageId,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final commentController = Get.find<CommentController>();

    final userId = authController.userData.value['\$id'];
    final role = authController.userData.value['role'];
    if (userId.isEmpty) {
      Get.snackbar('Error', 'Tidak dapat mengidentifikasi pengguna');
      return Container();
    }
    return Card(
      color: const Color.fromARGB(111, 224, 224, 224),
      shadowColor: Colors.black45,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<Uint8List?>(
              future: userImageId != null
                  ? authController.getImage(userImageId!)
                  : Future.value(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(snapshot.data!),
                  );
                }
                return const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                );
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  TextPrimary(text: comment.content),
                  const SizedBox(height: 4),
                  Text(
                    'Posted on: ${comment.createdAt.toString()}',
                    style: GoogleFonts.dmSans(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (comment.userId == userId || role == 'admin')
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        _showEditDialog(context, comment, commentController),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        _showDeleteDialog(context, comment, commentController),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, CommentModel comment,
      CommentController controller) {
    final TextEditingController textController =
        TextEditingController(text: comment.content);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextPrimary(text: 'Edit Komentar'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: "Edit your comment",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            cursorColor: AppColors.primary,
            maxLines: 3,
            minLines: 1,
          ),
          actions: [
            TextButton(
              child: TextPrimary(
                text: 'Batal',
                color: Colors.red,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: TextPrimary(text: 'Simpan', color: Colors.green),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  final updatedComment =
                      comment.copyWith(content: textController.text);
                  controller.updateComment(updatedComment);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, CommentModel comment,
      CommentController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextPrimary(text: 'Hapus Komentar'),
          content: TextPrimary(
              text: 'Apakah Anda yakin ingin menghapus komentar ini?'),
          actions: <Widget>[
            TextButton(
              child: TextPrimary(
                text: 'Batal',
                color: Colors.green,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: TextPrimary(
                text: 'Hapus',
                color: Colors.red,
              ),
              onPressed: () {
                controller.deleteComment(comment);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CommentForm extends StatelessWidget {
  final String artikelId;

  CommentForm({super.key, required this.artikelId});

  final commentController = Get.find<CommentController>();
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: contentController,
          decoration: InputDecoration(
            hintText: 'Tulis komentar Anda...',
            border: const OutlineInputBorder(),
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
          maxLines: 3,
          minLines: 1,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            if (contentController.text.isNotEmpty) {
              final userId = authController.userData.value['\$id'] ?? '';
              if (userId.isEmpty) {
                Get.snackbar('Error', 'Tidak dapat mengidentifikasi pengguna');
                return;
              }
              final now = DateTime.now();
              final formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
              final newComment = CommentModel(
                id: '',
                content: contentController.text,
                artikelId: artikelId,
                userId: userId,
                createdAt: formattedDate.toString(),
              );
              commentController.createComment(newComment);
              contentController.clear();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: TextPrimary(text: 'Kirim Komentar'),
        ),
      ],
    );
  }
}
