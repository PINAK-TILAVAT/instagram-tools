import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReelDownloaderController extends GetxController {
  // Text field controller
  final TextEditingController urlController = TextEditingController();

  // Loading state
  final RxBool isLoading = false.obs;

  // Downloaded reels history
  final RxList<Map<String, String>> downloadedReels =
      <Map<String, String>>[].obs;

  @override
  void onClose() {
    urlController.dispose();
    super.onClose();
  }

  // Download reel function
  void downloadReel() async {
    final url = urlController.text.trim();

    // Validate input
    if (url.isEmpty) {
      Get.snackbar(
        'Input Error',
        'Please enter a reel URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    // Validate URL format (basic check)
    if (!url.contains('instagram.com/reel') &&
        !url.contains('instagram.com/p/')) {
      Get.snackbar(
        'Invalid URL',
        'Please enter a valid Instagram reel URL',
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
      // This is just a simulated delay for demonstration
      await Future.delayed(const Duration(seconds: 2));

      // Add to download history
      final now = DateTime.now();
      final formattedDate = DateFormat('MMM d, yyyy h:mm a').format(now);

      downloadedReels.add({
        'url': url,
        'date': formattedDate,
        'path':
            '/storage/emulated/0/Download/Insta_Reel_${now.millisecondsSinceEpoch}.mp4',
      });

      // Simulate successful download
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Reel downloaded successfully',
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
        'Failed to download reel. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Play reel function
  void playReel(int index) {
    if (index >= 0 && index < downloadedReels.length) {
      final reel = downloadedReels[index];
      // In a real app, you would open the video player with the file path

      Get.snackbar(
        'Playing Reel',
        'Opening reel in video player...',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
