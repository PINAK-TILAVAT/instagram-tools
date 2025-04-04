import 'package:get/get.dart';
import 'package:instapro/story_downloader_controller.dart';

class StoryDownloaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StoryDownloaderController>(StoryDownloaderController());
  }
}
