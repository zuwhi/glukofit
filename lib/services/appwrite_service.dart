import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/constants/appwrite.dart';

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
      print('Error getting user document: $e');
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
    String status,
    int umur,
    int tinggi,
    int berat,
  ) async {
    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: userId,
        data: {
          'email': email,
          'nama': nama,
          'status': status,
          'umur': umur,
          'tinggi': tinggi,
          'berat': berat,
        },
      );
    } catch (e) {
      print('Failed to create user document: $e');
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
      print('Logout error: $e');
      rethrow;
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
      print('Error getting image: $e');
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
}
