import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/services/appwrite_service.dart';
import 'package:glukofit/views/artikel/artikel_list_view.dart';
import 'package:glukofit/views/chatbot/chatbot_view.dart';
import 'package:glukofit/views/dashboard/dashboard_view.dart';
import 'package:glukofit/views/diagnosa/diagnosa_view.dart';
import 'package:glukofit/views/diagnosa/result_diagnosa_view.dart';
import 'package:glukofit/views/homepage/homepage_view.dart';
import 'package:glukofit/views/login/auth_binding.dart';
import 'package:glukofit/views/login/login_view.dart';
import 'package:glukofit/views/nutrisi/search_nutrisi.dart';
import 'package:glukofit/views/produk/nutrisi_produk_view.dart';
import 'package:glukofit/views/produk/produk_from_image_view.dart';
import 'package:glukofit/views/produk/produk_view.dart';
import 'package:glukofit/views/register/register_view.dart';
import 'package:glukofit/views/scanner/scanner_view.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:glukofit/services/gemini_service.dart';


void main() async {
    Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppwriteService().init());
  Get.put(AuthController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(
        name: AppRoutes.dashboard,
        page: () => const DashboardView(),
        binding: BindingsBuilder(() {
          Get.put(AuthController());
        }),
      ),
      GetPage(
        name: AppRoutes.scanner,
        page: () => const ScannerView(),
      ),
      GetPage(
        name: AppRoutes.detailProduk,
        page: () => const ProdukView(),
      ),
      GetPage(
        name: AppRoutes.nutrisiProduk,
        page: () => const NutrisiProdukView(),
      ),
      GetPage(
        name: AppRoutes.diagnosa,
        page: () => const DiagnosaView(),
      ),
      GetPage(
        name: AppRoutes.resultDiagnosa,
        page: () => const ResultDiagnosaView(),
      ),
      GetPage(
        name: AppRoutes.searchNutrisi,
        page: () => const SearchNutrisiView(),
      ),
      GetPage(
        name: AppRoutes.produkFromImage,
        page: () => const ProdukFromImageView(),
      ),
      GetPage(
        name: AppRoutes.register,
        page: () => RegisterView(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: AppRoutes.login,
        page: () => LoginView(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: AppRoutes.artikel,
        page: () => const ArtikelListView(),
        binding: BindingsBuilder(() {
          Get.put(ArtikelController());
        }),
      ),
      GetPage(
        name: AppRoutes.homepage,
        page: () => const HomePageScreen(),
      ),
            GetPage(
        name: AppRoutes.ai,
        page: () => const ChatBotGeminiPage(),
      ),
    ],
    initialRoute: AppRoutes.dashboard,
  ));
}
