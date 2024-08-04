import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/services/appwrite_service.dart';

class AuthController extends GetxController {
  final AppwriteService _appwriteService = Get.find<AppwriteService>();

  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final userData = Rx<Map<String, dynamic>>({});

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
    } catch (e) {
      print('Error getting user data: $e');
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
      final session = await _appwriteService.createSession(
          email: email, password: password);
      isLoggedIn.value = true;
      await getUserData(session.userId);
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
      userData.value = {};
      Get.offAllNamed('/dashboard');
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout: $e');
    }
  }

  /*
  Future<void> updateUser({
    required String nama,
    required String status,
    required int umur,
    required int tinggi,
    required int berat,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final currentUser = await _appwriteService.account.get();
      final updatedData = Map<String, dynamic>.from(userData.value);
      
      updatedData['nama'] = nama;
      updatedData['status'] = status;
      updatedData['umur'] = umur;
      updatedData['tinggi'] = tinggi;
      updatedData['berat'] = berat;

      await _appwriteService.updateUserDocument(
        currentUser.$id,
        updatedData,
      );

      userData.value = updatedData;
      Get.snackbar('Success', 'User data updated successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to update user data');
    } finally {
      isLoading.value = false;
    }
  }
  */
}

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
