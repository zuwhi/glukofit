import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    Future.delayed(const Duration(seconds: 2), () async {
      await authController.checkLoginStatus();
      if (authController.isLoggedIn.value) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.welcome);
      }
    });
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Image.asset(
            "assets/icons/glukofit_splash.png",
            height: 130,
          ),
        ));
  }
}
