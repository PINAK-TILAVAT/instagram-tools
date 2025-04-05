import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_pages.dart';
import 'package:instapro/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final authController = Get.find<AuthController>();

  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is logged in
    if (!authController.isLoggedIn.value) {
      // Redirect to sign up page, unless we're already going there or to the splash
      if (route != Routes.SIGN_UP && route != Routes.SPLASH) {
        return const RouteSettings(name: Routes.SIGN_UP);
      }
    }

    return null;
  }

  @override
  Widget onPageBuilt(Widget page) {
    // You could add some logging or analytics here
    return page;
  }

  @override
  void onPageDispose() {
    // Clean up if needed when pages are disposed
  }
}
