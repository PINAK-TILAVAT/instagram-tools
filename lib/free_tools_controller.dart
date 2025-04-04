import 'package:get/get.dart';
import 'package:instapro/app_pages.dart';
import 'package:instapro/storage_service.dart';

class FreeToolsController extends GetxController {
  // Services
  final _storageService = Get.find<StorageService>();

  // Observable properties
  final isPremium = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  // Load user data from storage
  void _loadUserData() {
    isPremium.value = _storageService.isPremium();
  }

  // Navigation methods
  void navigateToStoryDownloader() {
    Get.toNamed(Routes.STORY_DOWNLOADER);
  }

  void navigateToReelDownloader() {
    Get.toNamed(Routes.REEL_DOWNLOADER);
  }
}
