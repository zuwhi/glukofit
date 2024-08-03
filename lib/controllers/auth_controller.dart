import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/services/appwrite_service.dart';

class AuthController extends GetxController {
  final AppwriteService _appwriteService = Get.find<AppwriteService>();

  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      await _appwriteService.account.get();
      isLoggedIn.value = true;
    } catch (e) {
      isLoggedIn.value = false;
    }
  }

  Future<void> register(
    String email,
    String password,
    String nama,
    String status,
    int umur,
    int tinggi,
    int berat,
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
        status,
        umur,
        tinggi,
        berat,
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
      await _appwriteService.createSession(email: email, password: password);
      isLoggedIn.value = true;
      Get.snackbar('Success', 'Logged in successfully');
      Get.offAllNamed(AppRoutes.dashboard);
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
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout: $e');
    }
  }
}

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
