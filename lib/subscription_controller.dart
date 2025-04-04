import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_constants.dart';
import 'package:instapro/storage_service.dart';

class SubscriptionController extends GetxController {
  final _storageService = Get.find<StorageService>();

  // Selected plan (default to yearly as best value)
  final Rx<String> selectedPlan = 'yearly'.obs;

  // Simulate subscription purchase
  void subscribeToPlan(String planType) async {
    // Show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Close loading dialog
    Get.back();

    // For now, simulate a successful purchase
    // In a real app, you would integrate with in-app purchase APIs
    // await _storageService.setBool(AppConstants.userPremiumKey, true);

    // Show success dialog
    Get.defaultDialog(
      title: 'Purchase Successful',
      middleText:
          'Thank you for upgrading to Premium! All features are now unlocked.',
      textConfirm: 'Continue',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.back(result: true); // Return to previous screen with success result
      },
    );
  }

  // Restore purchases
  void restorePurchases() async {
    // Show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Close loading dialog
    Get.back();

    // For now, we'll just show a message
    // In a real app, you would check with the app store if the user has purchased
    Get.snackbar(
      'Restore Purchases',
      'No previous purchases found',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
