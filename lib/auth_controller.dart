import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_pages.dart';
import 'package:instapro/storage_service.dart';

class AuthController extends GetxController {
  // Observables
  final RxBool isLoggedIn = false.obs;
  final RxString userName = ''.obs;
  final RxString phoneNumber = ''.obs;
  final RxString verificationId = ''.obs;

  // For storing user data in local storage later
  final _storage = Get.find<StorageService>();

  // Check if user is logged in
  Future<void> checkLoginStatus() async {
    // This will be implemented with Firebase later
    // For now, just check if we have user data in storage
    final savedUserName = _storage.getUserName();
    final savedPhoneNumber = _storage.getPhoneNumber();
    final userLoggedIn = _storage.isLoggedIn();

    if (userLoggedIn &&
        savedUserName.isNotEmpty &&
        savedPhoneNumber.isNotEmpty) {
      userName.value = savedUserName;
      phoneNumber.value = savedPhoneNumber;
      isLoggedIn.value = true;
    }
  }

  // Sign In with Phone Number (to be implemented with Firebase)
  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    String userName,
  ) async {
    this.phoneNumber.value = phoneNumber;
    this.userName.value = userName;

    // Will be implemented with Firebase Auth
    // For now, just simulate an OTP being sent
    // and navigate to OTP verification page
    Get.toNamed(Routes.OTP_VERIFICATION);
  }

  // Verify OTP (to be implemented with Firebase)
  Future<void> verifyOTP(String otp) async {
    // Will be implemented with Firebase Auth
    // For now, just simulate a successful verification

    // Set logged in status
    isLoggedIn.value = true;

    // Save user data to storage
    await _storage.setUserData(userName.value, phoneNumber.value);

    // Navigate to home
    Get.offAllNamed(Routes.HOME);
  }

  // Skip login
  void skipLogin() {
    Get.offAllNamed(Routes.SPLASH);
  }

  // Log out user
  Future<void> logout() async {
    isLoggedIn.value = false;
    userName.value = '';
    phoneNumber.value = '';

    // Clear stored user data
    await _storage.clearUserData();

    // Navigate to login page
    Get.offAllNamed(Routes.SIGN_UP);
  }
}
