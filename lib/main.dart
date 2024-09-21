import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/services/appwrite_service.dart';
import 'package:glukofit/views/BMI/kalkulator_BMI_view.dart';
import 'package:glukofit/views/BMR/bmr_view.dart';
import 'package:glukofit/views/artikel/add_edit_artikel_view.dart';
import 'package:glukofit/views/artikel/artikel_list_view.dart';
import 'package:glukofit/views/chatbot/chatbot_view.dart';
import 'package:glukofit/views/dashboard/dashboard_view.dart';
import 'package:glukofit/views/diagnosa/diagnosa_view.dart';
import 'package:glukofit/views/diagnosa/result_diagnosa_view.dart';
import 'package:glukofit/views/homepage/homepage_view.dart';
import 'package:glukofit/views/login/auth_binding.dart';
import 'package:glukofit/views/login/login_view.dart';
import 'package:glukofit/views/login/welcome_view.dart';
import 'package:glukofit/views/profile/profile_view.dart';
import 'package:glukofit/views/nutrisi/search_nutrisi.dart';
import 'package:glukofit/views/produk/nutrisi_produk_view.dart';
import 'package:glukofit/views/produk/produk_from_image_view.dart';
import 'package:glukofit/views/produk/produk_view.dart';
import 'package:glukofit/views/register/register_view.dart';
import 'package:glukofit/views/scanner/scanner_view.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:glukofit/services/gemini_service.dart';

import 'package:glukofit/views/splash_screen/splash_screen_view.dart';
import 'package:glukofit/views/tracker/tracker_view.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppwriteService().init());
  Get.put(AuthController());
  Get.put(ArtikelController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
    getPages: [
      GetPage(
        name: AppRoutes.dashboard,
        page: () => const HomePageScreen(),
        binding: BindingsBuilder(() {
          Get.put(AuthController());
        }),
      ),
      GetPage(
        name: AppRoutes.scanner,
        page: () => const ScannerView(),
      ),
      GetPage(
        name: AppRoutes.welcome,
        page: () => const WelcomeView(),
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
        name: AppRoutes.kalkulatorBMI,
        page: () => const KalkulatorBmiView(),
      ),
      GetPage(
        name: AppRoutes.tracker,
        page: () => const TrackerView(),
      ),
      GetPage(
        name: AppRoutes.bmr,
        page: () => const BmrView(),
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
        name: AppRoutes.profile,
        page: () => const ProfileView(),
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
        name: AppRoutes.artikel_add,
        page: () => const AddEditArtikelView(),
        binding: BindingsBuilder(() {
          Get.put(ArtikelController());
        }),
      ),
      GetPage(
        name: AppRoutes.ai,
        page: () => const ChatBotGeminiPage(),
      ),
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => const SplashScreen(),
      ),
    ],
    initialRoute: AppRoutes.splashScreen,
  ));
}
