import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glukofit/models/fatsecret_nutrition_model.dart';
import 'package:glukofit/models/fatsecret_product_model.dart';
import 'package:glukofit/models/nutrisi_model.dart';
import 'package:glukofit/models/product_scrap_model.dart';
import 'package:glukofit/models/produk_model.dart';
import 'package:glukofit/services/appwrite_produk_service.dart';
import 'package:logger/logger.dart';

enum ProdukScrapState { nutrisiScrap, listProductScrap, emptyScrap }

class ProdukController extends GetxController {
  final listProduk = RxList<ProdukModel>([]);
  final detailProduk = Rx<ProdukModel?>(null);
  final listProductScrap = Rx<List<ProductScrapModel>>([]);
  final nutrisiScrap = Rx<NutrisiScrapModel?>(null);
  final detailNutrisiScrap = Rx<NutrisiScrapModel?>(null);
  final listFatscretProductScrap = Rx<List<FatsecretProductScrapModel>?>(null);
  final listPencarianNutrisi = Rx<List<FatsecretProductScrapModel>?>(null);
  final fatsecretNutrisiScrap = Rx<FatsecretNutrisiScrapModel?>(null);
  final fatsecretTopNutrisiScrap = Rx<FatsecretNutrisiScrapModel?>(null);
  final RxBool isLoading = RxBool(false);
  final RxBool isLoadingOnNutritionView = RxBool(false);
  final RxBool isLoadingOnTopNutritionView = RxBool(false);
  final RxBool isLoaded = RxBool(false);
  final scrapState = Rx<ProdukScrapState>(ProdukScrapState.emptyScrap);
  final Dio dio = Dio();

  AppwriteProdukService produkService = AppwriteProdukService();
  Future<void> getProductByName(String name) async {
    try {
      isLoading.value = true;
      final response =
          await dio.get("https://scrap-gizi.vercel.app/scrape?cari=$name");
      final data = response.data;
      if (data is List) {
        scrapState.value = ProdukScrapState.listProductScrap;
        listProductScrap.value =
            productScrapModelFromJson(jsonEncode(response.data));
      } else if (data is Map) {
        scrapState.value = ProdukScrapState.nutrisiScrap;

        nutrisiScrap.value =
            nutrisiScrapModelFromJson(jsonEncode(response.data));
      } else {
        print('Unknown model type');
      }
      // List<ProductScrapModel> productScrap =
      //     productScrapModelFromJson(jsonEncode(response.data));
      // Logger().d(productScrap);

      // listProductScrap.value = productScrap;
    } catch (e) {
      Logger().d(e);
      Get.snackbar('Error', 'Failed to get produk: $e');
    } finally {
      isLoading.value = false;
    }
  }

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

  Future<void> getDetailProductFromScrap(String url) async {
    try {
      Logger().d("cek url: $url");
      isLoadingOnNutritionView.value = true;
      final response =
          await dio.get("https://scrap-gizi.vercel.app/scrape/detail?url=$url");
      final data = response.data;
      Logger().d(data);
      detailNutrisiScrap.value = nutrisiScrapModelFromJson(jsonEncode(data));
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoadingOnNutritionView.value = false;
    }
  }

  Future<void> getListProductFromFatsecretScrap(String product) async {
    try {
      Logger().d("proses");
      isLoading.value = true;
      final response = await dio
          .get("https://scrap-gizi.vercel.app/scrape/fatsecret/?q=$product");

      final data = response.data;
      listFatscretProductScrap.value =
          fatsecretProductScrapModelFromJson(jsonEncode(data));
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> getListPencarianNutrisi(String product) async {
    try {
      Logger().d("proses");
      isLoading.value = true;
      final response = await dio
          .get("https://scrap-gizi.vercel.app/scrape/fatsecret/?q=$product");

      final data = response.data;
      listPencarianNutrisi.value =
          fatsecretProductScrapModelFromJson(jsonEncode(data));
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getNutritionProductFromFatsecretScrap(String url) async {
    try {
      isLoadingOnNutritionView.value = true;
      final response = await dio.get(
          "https://scrap-gizi.vercel.app/scrape/fatsecret/product?url=$url");
      final data = response.data;
      fatsecretNutrisiScrap.value =
          fatsecretNutrisiScrapModelFromJson(jsonEncode(data));
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoadingOnNutritionView.value = false;
    }
  }
  Future<void> getTopNutritionProductFromFatsecretScrap(String url) async {
    try {
      isLoadingOnTopNutritionView.value = true;
      final response = await dio.get(
          "https://scrap-gizi.vercel.app/scrape/fatsecret/product?url=$url");
      final data = response.data;
      fatsecretTopNutrisiScrap.value =
          fatsecretNutrisiScrapModelFromJson(jsonEncode(data));
    } catch (e) {
      Get.snackbar('Error', 'Failed to get list produk: $e');
    } finally {
      isLoadingOnTopNutritionView.value = false;
    }
  }
}
