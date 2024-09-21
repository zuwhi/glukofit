import 'package:appwrite/appwrite.dart';
import 'package:glukofit/constants/appwrite.dart';
import 'package:glukofit/models/comment_model.dart';
import 'package:glukofit/services/appwrite_client_helper.dart';

class AppwriteCommentService {
  late Client _appwriteClient;
  late Databases databases;

  AppwriteCommentService() {
    _appwriteClient = AppwriteClientHelper.instance.appwriteClient;
    databases = Databases(_appwriteClient);
  }

  Future<CommentModel> createComment(CommentModel comment) async {
    try {
      final res = await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.commentCollectionId,
        documentId: ID.unique(),
        data: comment.toMap(),
      );

      return CommentModel(
        id: res.$id,
        content: comment.content,
        artikelId: comment.artikelId,
        userId: comment.userId,
        createdAt: comment.createdAt,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateComment(CommentModel comment) async {
    try {
      await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.commentCollectionId,
        documentId: comment.id,
        data: comment.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteComment(CommentModel comment) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.commentCollectionId,
        documentId: comment.id,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getCommentByArtikel(String artikelId) async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.commentCollectionId,
          queries: [Query.equal('artikelId', artikelId)]);

      return response.documents
          .map((e) => CommentModel.fromMap(e.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getCommentByUID(String uid) async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.commentCollectionId,
          queries: [Query.equal('uid', uid)]);

      return response.documents
          .map((e) => CommentModel.fromMap(e.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
