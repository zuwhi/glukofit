import 'package:get/get.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/services/appwrite_produk_service.dart';

class ProdukController extends GetxController {
  final listProduk = RxList<ProdukModel>([]);
  final detailProduk = Rx<ProdukModel?>(null);
  final RxBool isLoading = RxBool(false);
  final RxBool isLoaded = RxBool(false);

  AppwriteProdukService produkService = AppwriteProdukService();

  Future<void> getListProduk() async {
    if (isLoaded.value) return;

    try {
      isLoading.value = true;
      listProduk.value = await produkService.getListProduk();
      isLoaded.value = true; // Tandai bahwa data sudah dimuat
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProdukByNamaProduk(String produk) async {
    try {
      isLoading.value = true;
      detailProduk.value = await produkService.getProdukByNamaProduk(produk);
      isLoaded.value = true; // Tandai bahwa data sudah dimuat
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
