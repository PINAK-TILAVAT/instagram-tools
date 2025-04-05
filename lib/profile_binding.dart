import 'package:get/get.dart';

import 'package:instapro/auth_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Auth controller should already be initialized
    if (!Get.isRegistered<AuthController>()) {
      Get.put<AuthController>(AuthController());
    }
  }
}
