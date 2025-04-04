import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_pages.dart';
import 'package:instapro/storage_service.dart';
import 'package:instapro/theme_service.dart';

class HomeController extends GetxController {
  // Services
  final _storageService = Get.find<StorageService>();
  final _themeService = Get.find<ThemeService>();

  // Observable properties
  final isPremium = false.obs;
  final remainingGridUses = 0.obs;
  // We'll just use a fixed value instead of storing it
  final remainingCarouselUses = 3.obs; // Fixed number of carousel uses
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  // Load user data from storage
  void _loadUserData() {
    isPremium.value = _storageService.isPremium();
    remainingGridUses.value = _storageService.getRemainingGridUses();
    // No need to load carousel uses from storage
    isDarkMode.value = _themeService.isDarkMode;
  }

  // Toggle theme
  void toggleTheme() {
    _themeService.switchTheme();
    isDarkMode.value = _themeService.isDarkMode;
  }

  // Navigation methods
  void navigateToGridMaker() {
    if (!isPremium.value && remainingGridUses.value <= 0) {
      // Show upgrade prompt
      Get.defaultDialog(
        title: 'Upgrade Required',
        middleText:
            'You have used all your free grid uses. Upgrade to continue using this feature.',
        textConfirm: 'Upgrade',
        textCancel: 'Cancel',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(Routes.SUBSCRIPTION);
        },
        onCancel: () => Get.back(),
      );
      return;
    }

    Get.toNamed(Routes.GRID_MAKER);
  }

  void navigateToCarouselMaker() {
    if (!isPremium.value && remainingCarouselUses.value <= 0) {
      // Show upgrade prompt
      Get.defaultDialog(
        title: 'Upgrade Required',
        middleText:
            'You have used all your free carousel uses. Upgrade to continue using this feature.',
        textConfirm: 'Upgrade',
        textCancel: 'Cancel',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
          Get.toNamed(Routes.SUBSCRIPTION);
        },
        onCancel: () => Get.back(),
      );
      return;
    }

    Get.toNamed(Routes.CAROUSEL_MAKER);
  }

  // Navigate to Free Tools
  void navigateToFreeTools() {
    Get.toNamed(Routes.FREE_TOOLS);
  }

  // Decrease grid uses when a grid is created
  Future<void> decrementGridUses() async {
    if (!isPremium.value) {
      await _storageService.decrementGridUses();
      remainingGridUses.value = _storageService.getRemainingGridUses();
    }
  }

  // Decrease carousel uses when a carousel is created
  void decrementCarouselUses() {
    if (!isPremium.value && remainingCarouselUses.value > 0) {
      remainingCarouselUses.value--;
    }
  }
}
