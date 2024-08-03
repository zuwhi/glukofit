import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/services/appwrite_service.dart';
import 'package:glukofit/views/dashboard/dashboard_view.dart';
import 'package:glukofit/views/login/auth_binding.dart';
import 'package:glukofit/views/login/login_view.dart';
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
        name: AppRoutes.register,
        page: () => RegisterView(),
        binding: AuthBinding(),
      ),
      GetPage(
        name: AppRoutes.login,
        page: () => LoginView(),
        binding: AuthBinding(),
      ),
    ],
    initialRoute: AppRoutes.dashboard,
  ));
}
