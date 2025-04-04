import 'package:get/get.dart';
import 'package:instapro/free_tools_controller.dart';

class FreeToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FreeToolsController>(FreeToolsController());
  }
}
