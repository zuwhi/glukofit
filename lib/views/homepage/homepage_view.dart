import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glukofit/controllers/artikel_controller.dart';
import 'package:glukofit/models/artikel_model.dart';
import 'package:glukofit/views/artikel/widgets/card.dart';
import 'package:glukofit/views/global_widgets/buttomnavbar.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/views/artikel/artikel_detail_view.dart';

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
    final artikelController = Get.find<ArtikelController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage('assets/icons/sugaria_logo.png'),
                        width: 130,
                        height: 50,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 48, 94, 214),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Welcome User',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.tracker);
                      },
                      child: const SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 48, 94, 214),
                              radius: 25,
                              child: Image(
                                image: AssetImage('assets/images/gula.png'),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Text(
                              'Pantau\nGula',
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
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 48, 94, 214),
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
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 48, 94, 214),
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
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 48, 94, 214),
                                radius: 25,
                                child: Image(
                                    image: AssetImage('assets/images/ai.png'),
                                    width: 30,
                                    height: 30)),
                            Text(
                              'AI',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.searchNutrisi);
                        },
                        child: const SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 48, 94, 214),
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
                      const SizedBox(
                        width: 45,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.kalkulatorBMI);
                        },
                        child: const SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 48, 94, 214),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Daily Report',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  color: const Color.fromARGB(255, 48, 94, 214),
                  height: 130,
                ),
                const SizedBox(
                  height: 22,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Article For You',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  child: Obx(() {
                    final controller = Get.find<ArtikelController>();

                    if (controller.isLoading.value) {
                      return _buildLoadingIndicator();
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final artikel = controller.filteredArtikels[index];
                        return ArtikelCard(
                          artikel: artikel,
                          onTap: () => navigateToDetailPage(artikel),
                          isLarge: index % 70 == 15,
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 48, 94, 214),
        onPressed: () {
          Get.toNamed(AppRoutes.scanner);
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.circle,
          size: 50,
          color: Colors.white,
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
                color: Color.fromARGB(255, 48, 94, 214),
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
    return const SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildErrorIndicator(String errorMessage) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
