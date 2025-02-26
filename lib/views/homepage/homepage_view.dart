import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/controllers/tracker_controller.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/views/artikel/artikel_detail_view.dart';
import 'package:glukofit/views/artikel/widgets/card.dart';
import 'package:glukofit/views/global_widgets/buttomnavbar.dart';
import 'package:glukofit/views/homepage/widgets/card_pantau_kalori_on_home.dart';
import 'package:intl/intl.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void navigateToDetailPage(ArtikelModel artikel) {
    Get.to(() => ArtikelDetailView(artikel: artikel));
  }

  @override
  Widget build(BuildContext context) {
    final TrackerController controller = Get.put(TrackerController());
    final AuthController authController = Get.find();

    controller.countKalori(authController.userData.value['\$id']);
    controller.userId.value = authController.userData.value["\$id"];
    controller.pickedTime.value =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    controller.getListTracker();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage('assets/icons/logo.png'),
                        width: 130,
                        height: 50,
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: AppColors.primary,
                    //   child: Icon(
                    //     Icons.notifications,
                    //     color: Colors.white,
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Kalorimu hari ini ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black87),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.tracker);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: AppColors.primary,
                          border: Border.all(
                            color: AppColors.primary,
                          )),
                      height: 140,
                      child: controller.isLoadingGetBMR.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : CardPantauKaloriOnHome(controller: controller),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'List fitur',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black87),
                    )),
                const SizedBox(
                  height: 10.0,
                ),
                Wrap(
                  spacing: 23.0,
                  runSpacing: 5.0,
                  alignment: WrapAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.tracker);
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 25,
                              child: Image(
                                image: AssetImage('assets/images/gula.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Text(
                              'Pantau\nKalori',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.diagnosa);
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: 25,
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/diabetes.png'),
                                    width: 30,
                                    height: 30)),
                            Text(
                              'Check\nDiabetes',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.artikel);
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: 25,
                                child: Image(
                                    image:
                                        AssetImage('assets/images/artikel.png'),
                                    width: 30,
                                    height: 30)),
                            Text(
                              'Artikel',
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.ai);
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: 25,
                                child: Image(
                                    image: AssetImage('assets/images/ai.png'),
                                    width: 30,
                                    height: 30)),
                            Text(
                              'Chatbot',
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.searchNutrisi);
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 25,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/searchnutrisi.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Text(
                              'Cari \nNutrisi',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.kalkulatorBMI);
                      },
                      child: const SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary,
                              radius: 25,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/kalkulatorideal.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Text(
                              'Kalkulator\nIdeal',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Artikel untukmu',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  final controller = Get.find<ArtikelController>();

                  if (controller.isLoading.value) {
                    return _buildLoadingIndicator();
                  }

                  return SizedBox(
                      height: 350,
                      child: MasonryGridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final artikel = controller.filteredArtikels[index];
                          return ArtikelCard(
                            artikel: artikel,
                            onTap: () => navigateToDetailPage(artikel),
                            isLarge: false,
                          );
                        },
                      ));
                }),
              ],
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: SizedBox(
        height: 68,
        width: 68,
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.toNamed(AppRoutes.scanner);
          },
          shape: const CircleBorder(),
          child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: SvgPicture.asset(
                'assets/svg/scan.svg',
                height: 35,
                width: 35,
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget createGridItem(String imagePath, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildErrorIndicator(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
