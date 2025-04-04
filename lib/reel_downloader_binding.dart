import 'package:get/get.dart';
import 'package:instapro/reel_downloader_controller.dart';

class ReelDownloaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReelDownloaderController>(ReelDownloaderController());
  }
}
