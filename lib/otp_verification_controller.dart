import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/auth_controller.dart';

class OtpVerificationController extends GetxController {
  // OTP field controller
  final TextEditingController otpController = TextEditingController();

  // State variables
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxInt resendTime = 60.obs; // Countdown for resend button

  // Authentication controller
  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  // Start countdown for resend button
  void startResendTimer() {
    resendTime.value = 60;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendTime.value <= 0) return false;
      resendTime.value--;
      return true;
    });
  }

  // Verify the entered OTP
  Future<void> verifyOTP() async {
    if (otpController.text.trim().length != 6) {
      hasError.value = true;
      return;
    }

    isLoading.value = true;
    hasError.value = false;

    try {
      await _authController.verifyOTP(otpController.text.trim());
    } catch (e) {
      hasError.value = true;
      Get.snackbar(
        'Error',
        'Invalid OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Resend OTP
  Future<void> resendOTP() async {
    if (resendTime.value > 0) return;

    isLoading.value = true;

    try {
      // This would be implemented with Firebase
      // For now just restart the timer
      startResendTimer();

      Get.snackbar(
        'Success',
        'OTP has been resent',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
