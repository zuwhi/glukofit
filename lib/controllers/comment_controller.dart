import 'package:get/get.dart';
import 'package:glukofit/models/comment_model.dart';
import 'package:glukofit/services/appwrite_comment_service.dart';

class CommentController extends GetxController {
  final AppwriteCommentService _commentService = AppwriteCommentService();

  final RxList<CommentModel> comments = <CommentModel>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> createComment(CommentModel comment) async {
    try {
      isLoading.value = true;
      final createdComment = await _commentService.createComment(comment);
      comments.add(createdComment);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create comment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateComment(CommentModel comment) async {
    try {
      isLoading.value = true;
      await _commentService.updateComment(comment);
      int index = comments.indexWhere((c) => c.id == comment.id);
      if (index != -1) {
        comments[index] = comment;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update comment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteComment(CommentModel comment) async {
    try {
      isLoading.value = true;
      await _commentService.deleteComment(comment);
      comments.removeWhere((c) => c.id == comment.id);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete comment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCommentsByArtikel(String artikelId) async {
    try {
      isLoading.value = true;
      final fetchedComments =
          await _commentService.getCommentByArtikel(artikelId);
      comments.assignAll(fetchedComments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch comments: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCommentsByUID(String uid) async {
    try {
      isLoading.value = true;
      final fetchedComments = await _commentService.getCommentByUID(uid);
      comments.assignAll(fetchedComments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch comments: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
