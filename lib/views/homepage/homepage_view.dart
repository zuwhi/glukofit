import 'package:flutter/material.dart';
import 'package:glukofit/views/global_widgets/buttomnavbar.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage('assets/images/sugaria.png'),
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
                SizedBox(
                  height: 40,
                ),
                Align(
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
                              'Pantau \n  Gula',
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
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
                              '   Check\nDiabetes',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 48, 94, 214),
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
                    GestureDetector(
                      onTap: (){
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
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Daily Report',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 11,
                ),
                Container(
                  color: Color.fromARGB(255, 48, 94, 214),
                  height: 130,
                ),
                SizedBox(
                  height: 22,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Article For You',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      createGridItem('assets/images/test.jpg',
                          'Kenali beberapa obat untuk penyakit diabetes'),
                      createGridItem('assets/images/test.jpg',
                          'Sering merasa pusing? Kenali obat pereda rasa sakit'),
                      createGridItem('assets/images/test.jpg',
                          'Kenali beberapa obat untuk penyakit diabetes'),
                      createGridItem('assets/images/test.jpg',
                          'Sering merasa pusing? Kenali obat pereda rasa sakit'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 48, 94, 214),
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(
          Icons.circle,size: 50,
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
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 48, 94, 214),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Text(
                text,
                style: TextStyle(
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
}
