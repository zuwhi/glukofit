import 'package:appwrite/appwrite.dart';
import 'package:glukofit/constants/appwrite.dart';
import 'package:glukofit/models/tracker_model.dart';
import 'package:glukofit/services/appwrite_client_helper.dart';
import 'package:logger/logger.dart';

class AppwriteTrackerService {
  late Client _appwriteClient;
  late Databases databases;

  // ignore: non_constant_identifier_names
  AppwriteTrackerService() {
    _appwriteClient = AppwriteClientHelper.instance.appwriteClient;
    databases = Databases(_appwriteClient);
  }

  Future<List<TrackerModel>> getListTracker(String date, String userId) async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.riwayatCollectionId,
          queries: [
            Query.equal('userId', [userId]),
            Query.equal('tanggal', [date]),
            Query.orderDesc('jam'),
          ]);

      return response.documents
          .map((e) => TrackerModel.fromMap(e.data))
          .toList();
    } on AppwriteException catch (e) {
      Logger().d(e.message);
      throw Exception(e.message);
    }
  }

  Future<void> addTracker(TrackerModel tracker) async {
    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.riwayatCollectionId,
        documentId: ID.unique(),
        data: {
          'userId': tracker.userId,
          'keterangan': tracker.keterangan,
          'jam': tracker.jam,
          'tanggal': tracker.tanggal,
          'gula': tracker.gula,
          'kalori': tracker.kalori
        },
      );
    } on AppwriteException catch (e) {
      Logger().d(e.message);
      throw Exception(e.message);
    }
  }

  Future<void> deleteTracker(id) async {
    try {
      await databases.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.riwayatCollectionId,
        documentId: id,
      );
    } on AppwriteException catch (e) {
      Logger().d(e.message);
      throw Exception(e.message);
    }
  }

  Future<void> updateTracker(TrackerModel tracker) async {
    try {
      await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.riwayatCollectionId,
        documentId: tracker.id,
        data: {
          'userId': tracker.userId,
          'keterangan': tracker.keterangan,
          'jam': tracker.jam,
          'tanggal': tracker.tanggal,
          'gula': tracker.gula,
          'kalori': tracker.kalori
        },
      );
    } on AppwriteException catch (e) {
      Logger().d(e.message);
      throw Exception(e.message);
    }
  }
}
