import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/produk_controller.dart';

class DashboardView extends GetView<AuthController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProdukController>(() => ProdukController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.welcome);
                  },
                  child: const Text("Go to login")),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  child: const Text("Go to register")),
              ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },
                  child: const Text("logout")),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.artikel);
                  },
                  child: const Text("artikel")),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.diagnosa);
                  },
                  child: const Text("diagnosa")),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.scanner);
                  },
                  child: const Text("Go to scanner view")),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.searchNutrisi);
                  },
                  child: const Text("search nutrisi")),
              const SizedBox(height: 20),
              const Text(
                "User Data:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (controller.isLoggedIn.value) {
                  final userData = controller.userData.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${userData['nama'] ?? 'N/A'}"),
                      Text("Email: ${userData['email'] ?? 'N/A'}"),
                      Text("Status: ${userData['status'] ?? 'N/A'}"),
                      Text("Age: ${userData['umur']?.toString() ?? 'N/A'}"),
                      Text(
                          "Height: ${userData['tinggi']?.toString() ?? 'N/A'} cm"),
                      Text(
                          "Weight: ${userData['berat']?.toString() ?? 'N/A'} kg"),
                    ],
                  );
                } else {
                  return const Text("Please log in to view user data.");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
