// otp_verification_binding.dart
import 'package:get/get.dart';

import 'package:instapro/auth_controller.dart';
import 'package:instapro/otp_verification_controller.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure AuthController is available
    if (!Get.isRegistered<AuthController>()) {
      Get.put<AuthController>(AuthController());
    }

    // OtpVerificationController
    Get.put<OtpVerificationController>(OtpVerificationController());
  }
}
