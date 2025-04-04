import 'package:get/get.dart';
import 'package:instapro/carousel_maker_controller.dart';

class CarouselMakerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CarouselMakerController>(CarouselMakerController());
  }
}
