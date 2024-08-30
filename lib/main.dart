import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/services/appwrite_service.dart';
import 'package:glukofit/views/artikel/artikel_list_view.dart';
import 'package:glukofit/views/dashboard/dashboard_view.dart';
import 'package:glukofit/views/diagnosa/diagnosa_view.dart';
import 'package:glukofit/views/diagnosa/result_diagnosa_view.dart';
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

void main() async {
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
        name: AppRoutes.profil,
        page: () => const ProfileView(),
      ),
    ],
    // initialRoute: AppRoutes.welcome,
    initialBinding: BindingsBuilder(() {
      Get.put(AuthController());
    }),
    home: const Root(),
  ));
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      builder: (controller) {
        if (controller.isLoggedIn.value) {
          return const DashboardView();
        } else {
          return const WelcomeView();
        }
      },
    );
  }
}
