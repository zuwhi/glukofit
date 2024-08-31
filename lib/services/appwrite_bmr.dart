import 'package:appwrite/appwrite.dart';
import 'package:glukofit/constants/appwrite.dart';
import 'package:glukofit/models/bmr_model.dart';
import 'package:glukofit/services/appwrite_client_helper.dart';
import 'package:logger/logger.dart';

class AppwriteBmrService {
  late Client _appwriteClient;
  late Databases databases;

  AppwriteBmrService() {
    _appwriteClient = AppwriteClientHelper.instance.appwriteClient;
    databases = Databases(_appwriteClient);
  }

  Future<void> addBmr(BMRModel bmr) async {
    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.kaloriCollectionId,
        documentId: ID.unique(),
        data: {'userId': bmr.userId, 'total': bmr.total},
      );
    } on AppwriteException catch (e) {
      Logger().d(e.message);
      throw Exception(e.message);
    }
  }

  Future<void> updateBmr(BMRModel bmr) async {
    try {
      await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.kaloriCollectionId,
        documentId: bmr.id,
        data: {'total': bmr.total},
      );
    } on AppwriteException catch (e) {
      Logger().d(e.message);
      throw Exception(e.message);
    }
  }

  Future<BMRModel?> getBmr(String userId) async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.kaloriCollectionId,
          queries: [
            Query.equal('userId', [userId]),
          ]);
      Logger().d(response.documents[0].data.toString());

      return BMRModel.fromMap(response.documents[0].data);
    } on AppwriteException catch (e) {
      Logger().d("cek error : ${e.message}");
      return null;
    } catch (e) {
      Logger().d("cek error : $e");
      return null;
    }
  }
}
