import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/storage_service.dart';

class StoryDownloaderController extends GetxController {
  final _storageService = Get.find<StorageService>();

  // Text field controller
  final TextEditingController urlController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  // Error message
  final RxString errorMessage = ''.obs;

  @override
  void onClose() {
    urlController.dispose();
    super.onClose();
  }

  // Download story function
  void downloadStory() async {
    final url = urlController.text.trim();

    // Validate input
    if (url.isEmpty) {
      Get.snackbar(
        'Input Error',
        'Please enter a username or story URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    // Set loading state
    isLoading.value = true;

    try {
      // In a real app, you would implement the actual download logic here
      // This is just a simulated delay for demonstration purposes
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful download
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Story downloaded successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      // Clear the input field
      urlController.clear();
    } catch (e) {
      // Handle errors
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to download story. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}
