import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instapro/app_constants.dart';
import 'package:instapro/app_pages.dart';
import 'package:instapro/app_theme.dart';
import 'package:instapro/storage_service.dart';
import 'package:instapro/theme_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize StorageService (shared preferences wrapper)
  await Get.putAsync(() => StorageService().init());

  // Initialize ThemeService
  Get.put(ThemeService());

  runApp(const InstagramToolsApp());
}

class InstagramToolsApp extends StatelessWidget {
  const InstagramToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get ThemeService to observe theme changes
    final themeService = Get.find<ThemeService>();

    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.themeMode,

      // App routing
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      // Default transition effect
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),

      // Locale settings
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
