import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.welcome);
    });
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(
            child: Image.asset(
              "assets/icons/sugaria_splash.png",
              height: 130,
            ),
          )),
    );
  }
}
