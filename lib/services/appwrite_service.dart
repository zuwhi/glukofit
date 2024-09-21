import 'dart:typed_data';
import 'dart:io' as io;
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/constants/appwrite.dart';
import 'package:glukofit/models/artikel_model.dart';

class AppwriteService extends GetxService {
  Client client = Client();
  late Account account;
  late Databases databases;
  late Storage storage;

  Future<AppwriteService> init() async {
    client
        .setEndpoint(AppwriteConstants.endpoint)
        .setProject(AppwriteConstants.projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
    return this;
  }

  Future<User> createAccount(
      {required String email, required String password}) async {
    try {
      final result = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserDocument(String userId) async {
    try {
      final document = await databases.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: userId,
      );
      return document.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserDocument(
      String userId, Map<String, dynamic> data) async {
    try {
      await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: userId,
        data: data,
      );
    } catch (e) {
      print('Error updating user document: $e');
      rethrow;
    }
  }

  Future<void> createUserDocument(
    String userId,
    String email,
    String nama,
  ) async {
    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: userId,
        data: {
          'email': email,
          'nama': nama,
          'status': 'Non Diabetes',
          'umur': 0,
          'tinggi': 0,
          'berat': 0,
          'imageId': '',
          'role': 'user'
        },
      );
    } catch (e) {
      throw Exception('Failed to initialize user data');
    }
  }

  Future<Session> createSession(
      {required String email, required String password}) async {
    try {
      final result = await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadUserImage(io.File file, String fileName) async {
    try {
      final result = await storage.createFile(
        bucketId: AppwriteConstants.userBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path, filename: fileName),
      );
      return result.$id;
    } on AppwriteException catch (e) {
      throw Exception('Failed to upload file: ${e.message}');
    }
  }

  Future<Uint8List?> getProfileImage(String imageId) async {
    try {
      final res = await storage.getFileView(
        bucketId: AppwriteConstants.userBucketId,
        fileId: imageId,
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUserImage(String imageId) async {
    try {
      await storage.deleteFile(
        bucketId: AppwriteConstants.userBucketId,
        fileId: imageId,
      );
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<Uint8List?> getArtikelImage(String imageId) async {
    try {
      final res = await storage.getFileView(
        bucketId: AppwriteConstants.artikelBucketId,
        fileId: imageId,
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<List<Document>> getAllArtikel() async {
    final documents = await databases.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.artikelCollectionId,
    );
    return documents.documents;
  }

  Future<void> addArtikel(ArtikelModel artikel) async {
    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.artikelCollectionId,
        documentId: ID.unique(),
        data: artikel.toMap(),
      );
    } catch (e) {
      throw Exception('Failed to add article');
    }
  }

  Future<String> uploadArtikelImage(io.File file, String fileName) async {
    try {
      final result = await storage.createFile(
        bucketId: AppwriteConstants.artikelBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path, filename: fileName),
      );
      return result.$id;
    } on AppwriteException catch (e) {
      throw Exception('Failed to upload file: ${e.message}');
    }
  }

  Future<void> deleteArtikelImage(String imageId) async {
    try {
      await storage.deleteFile(
        bucketId: AppwriteConstants.artikelBucketId,
        fileId: imageId,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateArtikel(ArtikelModel artikel) async {
    try {
      await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.artikelCollectionId,
        documentId: artikel.id,
        data: artikel.toMap(),
      );
    } catch (e) {
      throw Exception('Failed to update article: $e');
    }
  }

  Future<void> deleteArtikel(String id) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.artikelCollectionId,
        documentId: id,
      );
    } catch (e) {
      throw Exception('Failed to delete article: $e');
    }
  }
}
