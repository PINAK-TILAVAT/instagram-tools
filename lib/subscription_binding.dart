import 'package:get/get.dart';
import 'package:instapro/subscription_controller.dart';

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SubscriptionController>(SubscriptionController());
  }
}
