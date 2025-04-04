import 'package:get/get.dart';
import 'package:instapro/grid_maker_controller.dart';

class GridMakerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GridMakerController>(GridMakerController());
  }
}
