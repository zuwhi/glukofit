import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_colors.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/controllers/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController ageController = TextEditingController();
  // final TextEditingController heightController = TextEditingController();
  // final TextEditingController weightController = TextEditingController();

  // final RxString selectedStatus = 'Non Diabetes'.obs;
  // final List<String> statusOptions = ['Diabetes', 'Non Diabetes'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool _isPasswordVisible = false.obs;

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    void register() {
      if (_formKey.currentState!.validate()) {
        controller.register(
            emailController.text, passwordController.text, nameController.text);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 140,
                      width: 170,
                      child: Image.asset('assets/icons/logo.png')),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create an account',
                      style: GoogleFonts.dmSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 12.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 12.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      // if (!GetUtils.isEmail(value)) {
                      //   return 'Please enter a valid email';
                      // }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Obx(() => TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _isPasswordVisible.value =
                                  !_isPasswordVisible.value;
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 12.0),
                        ),
                        obscureText: !_isPasswordVisible.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          if (value.length < 8) {
                            return 'Password harus minimal 8 karakter';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => register(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                      child: Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'REGISTER',
                                style: GoogleFonts.dmSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      )),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF615D5E),
                        ),
                        children: [
                          TextSpan(
                              text: 'Sign in',
                              style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.orange),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.register);
                                })
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// const SizedBox(height: 16),
//                   Obx(() => DropdownButtonFormField<String>(
//                         value: selectedStatus.value,
//                         items: statusOptions.map((String status) {
//                           return DropdownMenuItem<String>(
//                             value: status,
//                             child: Text(status),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           selectedStatus.value = newValue!;
//                         },
//                         decoration: const InputDecoration(labelText: 'Status'),
//                       )),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: ageController,
//                     decoration: const InputDecoration(labelText: 'Age'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your age';
//                       }
//                       if (!GetUtils.isNum(value)) {
//                         return 'Please enter a valid age';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: heightController,
//                     decoration: const InputDecoration(labelText: 'Height (cm)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your height';
//                       }
//                       if (!GetUtils.isNum(value)) {
//                         return 'Please enter a valid height';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: weightController,
//                     decoration: const InputDecoration(labelText: 'Weight (kg)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your weight';
//                       }
//                       if (!GetUtils.isNum(value)) {
//                         return 'Please enter a valid weight';
//                       }
//                       return null;
//                     },
//                   ),