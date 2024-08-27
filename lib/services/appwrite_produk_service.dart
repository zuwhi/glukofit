import 'package:appwrite/appwrite.dart';
import 'package:glukofit/constants/appwrite.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/services/appwrite_client_helper.dart';
import 'package:logger/logger.dart';

class AppwriteProdukService {
  late Client _appwriteClient;
  late Databases databases;

  AppwriteProdukService() {
    _appwriteClient = AppwriteClientHelper.instance.appwriteClient;
    databases = Databases(_appwriteClient);
  }
  Future<List<ProdukModel>> getListProduk() async {
    try {
      final response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.produkCollectionId,
      );
      Logger().d(response);
      Logger().d(response.documents[0]);
      return response.documents
          .map((e) => ProdukModel.fromMap(e.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProdukModel?> getProdukByNamaProduk(String produk) async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.produkCollectionId,
          queries: [
            Query.equal('nama_produk', [produk]),
          ]);
      Logger().d(response);
      Logger().d(response.documents);
      Logger().d(response.documents[0]);
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
