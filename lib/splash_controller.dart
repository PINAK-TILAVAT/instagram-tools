import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_pages.dart';

import 'package:instapro/auth_controller.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> fadeAnimation;

  // Get auth controller
  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Check user auth status
    await _authController.checkLoginStatus();

    // Wait for splash animation
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () => Get.offAllNamed(Routes.HOME),
    );
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}
