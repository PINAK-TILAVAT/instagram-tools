import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_constants.dart';
import 'package:instapro/storage_service.dart';

class ThemeService extends GetxService {
  final _storageService = Get.find<StorageService>();

  // Observable theme mode
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  // Getter for current theme mode
  ThemeMode get themeMode => _themeMode.value;

  // Getter to check if dark mode is enabled
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    // _loadThemeFromStorage();
  }

  // Load saved theme mode from storage
  // void _loadThemeFromStorage() {
  //   final savedTheme = _storageService.getString(AppConstants.themeKey);

  //   if (savedTheme != null) {
  //     if (savedTheme == 'dark') {
  //       _themeMode.value = ThemeMode.dark;
  //     } else if (savedTheme == 'light') {
  //       _themeMode.value = ThemeMode.light;
  //     } else {
  //       _themeMode.value = ThemeMode.system;
  //     }
  //   } else {
  //     // Default to system theme if no saved preference
  //     _themeMode.value = ThemeMode.system;
  //   }
  // }

  // Switch between light and dark modes
  void switchTheme() {
    if (_themeMode.value == ThemeMode.dark) {
      _themeMode.value = ThemeMode.light;
      _saveThemeMode('light');
      Get.changeThemeMode(ThemeMode.light);
    } else {
      _themeMode.value = ThemeMode.dark;
      _saveThemeMode('dark');
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  // Set a specific theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);

    switch (mode) {
      case ThemeMode.light:
        _saveThemeMode('light');
        break;
      case ThemeMode.dark:
        _saveThemeMode('dark');
        break;
      case ThemeMode.system:
        _saveThemeMode('system');
        break;
    }
  }

  // Save theme preference to storage
  void _saveThemeMode(String mode) {
    // _storageService.setString(AppConstants.themeKey, mode);
  }
}
