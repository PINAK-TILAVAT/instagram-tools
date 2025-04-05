import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/auth_controller.dart';

class SignUpController extends GetxController {
  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Form validation
  final RxBool isNameValid = false.obs;
  final RxBool isPhoneValid = false.obs;
  final RxBool isLoading = false.obs;

  // Get auth controller instance
  final AuthController _authController = Get.find<AuthController>();

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Validate name field
  void validateName(String value) {
    isNameValid.value = value.trim().isNotEmpty;
  }

  // Validate phone field
  void validatePhone(String value) {
    // Simple validation, can be enhanced
    isPhoneValid.value = value.trim().length >= 10;
  }

  // Check if form is valid
  bool get isFormValid => isNameValid.value && isPhoneValid.value;

  // Generate OTP and proceed to verification
  Future<void> generateOTP() async {
    if (!isFormValid) return;

    isLoading.value = true;

    try {
      await _authController.signInWithPhoneNumber(
        phoneController.text.trim(),
        nameController.text.trim(),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Skip login
  void skipLogin() {
    _authController.skipLogin();
  }
}
