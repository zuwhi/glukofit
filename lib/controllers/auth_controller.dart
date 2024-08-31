import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/services/appwrite_service.dart';

class AuthController extends GetxController {
  final AppwriteService _appwriteService = Get.find<AppwriteService>();

  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final userData = Rx<Map<String, dynamic>>({});
  Rx<Uint8List?> profileImage = Rx<Uint8List?>(null);
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final account = await _appwriteService.account.get();
      isLoggedIn.value = true;
      await getUserData(account.$id);
    } catch (e) {
      isLoggedIn.value = false;
    }
  }

  Future<void> getUserData(String userId) async {
    try {
      final data = await _appwriteService.getUserDocument(userId);
      userData.value = data;
      if (userData.value['imageId'] != null &&
          userData.value['imageId'] != '') {
        await getProfileImage(userData.value['imageId']);
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> register(
    String email,
    String password,
    String nama,
  ) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final account = await _appwriteService.createAccount(
          email: email, password: password);

      await _appwriteService.createUserDocument(
        account.$id,
        email,
        nama,
      );

      Get.snackbar('Success', 'Account created successfully');
      Get.offNamedUntil(
        AppRoutes.login,
        (route) => false,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to create account');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final session = await _appwriteService.createSession(
          email: email, password: password);
      isLoggedIn.value = true;
      await getUserData(session.userId);
      Get.snackbar('Success', 'Logged in successfully');
      Get.offAllNamed(AppRoutes.homepage);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to login');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _appwriteService.logout();
      isLoggedIn.value = false;
      userData.value = {};
      Get.offAllNamed('/welcome');
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout: $e');
    }
  }

  Future<void> updateUser({
    required String nama,
    required String status,
    required String email,
    required String phone,
    required String role,
    required int umur,
    required int tinggi,
    required int berat,
    File? newImage,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currentUser = await _appwriteService.account.get();
      final updatedData = {
        'nama': nama,
        'status': status,
        'tinggi': tinggi,
        'berat': berat,
        'umur': umur,
        'phone': phone,
      };

      if (newImage != null) {
        if (userData.value['imageId'] != null &&
            userData.value['imageId'].isNotEmpty) {
          await _appwriteService.deleteUserImage(userData.value['imageId']);
        }

        final imageId =
            await _appwriteService.uploadUserImage(newImage, currentUser.$id);
        updatedData['imageId'] = imageId;
      }

      await _appwriteService.updateUserDocument(
        currentUser.$id,
        updatedData,
      );

      userData.value = {
        ...userData.value,
        ...updatedData,
        'imageId': newImage != null
            ? updatedData['imageId']
            : userData.value['imageId'],
      };
      Get.snackbar('Success', 'User data updated successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProfileImage(String imageId) async {
    try {
      final res = await _appwriteService.getProfileImage(
        imageId,
      );
      profileImage.value = res;
    } catch (e) {
      profileImage.value = null;
    }
  }
}

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
