import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:glukofit/views/global_widgets/buttomnavbar.dart';
import 'package:glukofit/views/global_widgets/button_primary.dart';
import 'package:glukofit/views/global_widgets/text_primary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_routes.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthController controller = Get.put(AuthController());
  File? image;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  String selectedStatus = 'Non Diabetes';
  Uint8List? profileImageData;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    ageController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();

    if (controller.isLoggedIn.value) {
      final userData = controller.userData.value;
      nameController.text = userData['nama'] ?? '';
      emailController.text = userData['email'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      ageController.text = userData['umur']?.toString() ?? '';
      heightController.text = userData['tinggi']?.toString() ?? '';
      weightController.text = userData['berat']?.toString() ?? '';
      selectedStatus = userData['status'] ?? 'Non Diabetes';
      if (userData['imageId'] != null && userData['imageId'] != '') {
        controller.getProfileImage(userData['imageId']);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Profile',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/back.png',
              width: 12,
              height: 26,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                Get.dialog(Dialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          "Konfirmasi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Apakah Anda yakin ingin keluar dari akun ini?",
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: TextPrimary(
                                  text: "Batal",
                                  color: AppColors.primary,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: ButtonPrimary(
                                text: "Keluar",
                                onPressed: () {
                                  controller.logout();
                                },
                                isActive: true,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
              },
            ),
          ]),
      body: Obx(() {
        if (controller.isLoggedIn.value) {
          final userData = controller.userData.value;
          if (controller.userData.value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 95.0,
                        color: AppColors.primary,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: image != null
                                  ? CircleAvatar(
                                      radius: 55,
                                      backgroundImage: FileImage(image!),
                                    )
                                  : (userData['imageId'] != '' &&
                                          userData['imageId'] != null)
                                      ? CircleAvatar(
                                          radius: 55,
                                          backgroundImage: MemoryImage(
                                              controller.profileImage.value!),
                                        )
                                      : const CircleAvatar(
                                          radius: 55,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                            Icons.person,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                            ),
                            TextButton(
                              onPressed: pickImage,
                              child: Text(
                                'Change Picture',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Nama'),
                      _buildTextField(nameController),
                      const SizedBox(height: 16),
                      _buildLabel('Email'),
                      _buildTextField(emailController, isEmail: true),
                      const SizedBox(height: 16),
                      _buildLabel('Phone Number'),
                      _buildTextField(phoneController),
                      const SizedBox(height: 16),
                      _buildLabel('Status'),
                      _buildDropdown(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Umur'),
                                _buildTextFieldCentered(ageController),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Tinggi'),
                                _buildTextFieldCentered(heightController),
                              ],
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Berat'),
                                _buildTextFieldCentered(weightController),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await controller.updateUser(
                                      nama: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      status: selectedStatus,
                                      umur: int.parse(ageController.text),
                                      tinggi: int.parse(heightController.text),
                                      berat: int.parse(weightController.text),
                                      newImage: image,
                                      role: controller.userData.value['role'],
                                    );
                                  } catch (e) {
                                    Get.snackbar('Error',
                                        'Failed to update profile: $e');
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColors.orange,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Edit Profile',
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Please log in to view user data."),
          );
        }
      }),
      extendBody: true,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: SizedBox(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    bool isEmail = false,
    bool isPhone = false,
  }) {
    return TextFormField(
      readOnly: isEmail,
      controller: controller,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini tidak boleh kosong';
        }
        if (isEmail) {
          String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
          RegExp regex = RegExp(emailPattern);
          if (!regex.hasMatch(value)) {
            return 'Masukkan alamat email yang valid';
          }
        }
        return null;
      },
    );
  }

  Widget _buildTextFieldCentered(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      value: selectedStatus,
      items: ['Non Diabetes', 'Diabetes']
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedStatus = value!;
        });
      },
    );
  }
}
