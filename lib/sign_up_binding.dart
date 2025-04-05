// sign_up_binding.dart
import 'package:get/get.dart';

import 'package:instapro/auth_controller.dart';
import 'package:instapro/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure AuthController is available
    Get.put<AuthController>(AuthController());

    // SignUpController
    Get.put<SignUpController>(SignUpController());
  }
}
