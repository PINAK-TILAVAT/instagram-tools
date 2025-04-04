import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:instapro/home_controller.dart';
import 'package:share_plus/share_plus.dart';

class CarouselMakerController extends GetxController {
  // Dependencies
  final HomeController homeController = Get.find<HomeController>();

  // Observables
  final RxList<File> selectedImages = <File>[].obs;
  final RxBool isProcessing = false.obs;
  final RxBool isCarouselGenerated = false.obs;
  final RxDouble progress = 0.0.obs;
  final RxInt maxImages = 10.obs;
  final RxInt minImages = 2.obs;

  // Image picker
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // Clean up temporary files
    _cleanupTempFiles();
    super.onClose();
  }

  // Pick multiple images from gallery
  Future<void> pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 100);

    if (images.isNotEmpty) {
      // Check if adding these would exceed the maximum
      if (selectedImages.length + images.length > maxImages.value) {
        Get.snackbar(
          'Too many images',
          'You can only select up to ${maxImages.value} images. Only adding the first ${maxImages.value - selectedImages.length}.',
          backgroundColor: Colors.amber,
          colorText: Colors.black,
        );

        // Only add images up to the max limit
        final int spaceLeft = maxImages.value - selectedImages.length;
        for (int i = 0; i < spaceLeft && i < images.length; i++) {
          selectedImages.add(File(images[i].path));
        }
      } else {
        // Add all selected images
        for (final XFile image in images) {
          selectedImages.add(File(image.path));
        }
      }
    }
  }

  // Capture image with camera
  Future<void> captureImage() async {
    // Check if we've reached max images
    if (selectedImages.length >= maxImages.value) {
      Get.snackbar(
        'Maximum reached',
        'You can only select up to ${maxImages.value} images.',
        backgroundColor: Colors.amber,
        colorText: Colors.black,
      );
      return;
    }

    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  // Remove image at specific index
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      // Show confirmation dialog
      Get.defaultDialog(
        title: 'Remove Image',
        middleText: 'Are you sure you want to remove this image?',
        textConfirm: 'Yes',
        textCancel: 'No',
        confirmTextColor: Colors.white,
        onConfirm: () {
          selectedImages.removeAt(index);
          Get.back();
        },
        onCancel: () => Get.back(),
      );
    }
  }

  // Reorder images
  void reorderImages(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final File item = selectedImages.removeAt(oldIndex);
    selectedImages.insert(newIndex, item);
  }

  // Generate carousel from the selected images
  Future<void> generateCarousel() async {
    if (selectedImages.length < minImages.value) {
      Get.snackbar(
        'Not enough images',
        'Please select at least ${minImages.value} images.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isProcessing.value = true;
    progress.value = 0.0;

    try {
      // Create directory for carousel images
      final Directory tempDir = await getTemporaryDirectory();
      final String carouselPath = '${tempDir.path}/carousel_images';
      final Directory carouselDir = Directory(carouselPath);

      if (await carouselDir.exists()) {
        await carouselDir.delete(recursive: true);
      }

      await carouselDir.create(recursive: true);

      // Process images
      final int totalImages = selectedImages.length;
      for (int i = 0; i < totalImages; i++) {
        final File originalImage = selectedImages[i];

        // Copy image to temp directory with sequential naming
        final String outputPath = '$carouselPath/carousel_${i + 1}.jpg';
        await originalImage.copy(outputPath);

        // Update progress
        progress.value = (i + 1) / totalImages;
      }

      // Decrement carousel uses if not premium
      if (!homeController.isPremium.value) {
        homeController.decrementCarouselUses();
      }

      isCarouselGenerated.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate carousel: $e');
    } finally {
      isProcessing.value = false;
    }
  }

  // Save carousel images to gallery
  Future<void> saveCarouselToGallery() async {
    if (selectedImages.isEmpty) return;

    try {
      isProcessing.value = true;
      progress.value = 0.0;

      // Create a Pictures directory if it doesn't exist
      final directory = Directory(
        '${(await getExternalStorageDirectory())!.path}/Pictures/InstaPro/Carousel',
      );
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final int totalImages = selectedImages.length;
      int savedCount = 0;
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      for (int i = 0; i < totalImages; i++) {
        final String fileName = 'carousel_${timestamp}_${i + 1}.jpg';
        final String filePath = '${directory.path}/$fileName';

        // Copy the file to Pictures directory
        await selectedImages[i].copy(filePath);

        savedCount++;
        progress.value = (i + 1) / totalImages;
      }

      Get.snackbar(
        'Success',
        'Saved $savedCount carousel images to Pictures/InstaPro/Carousel',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to save carousel: $e');
    } finally {
      isProcessing.value = false;
    }
  }

  // Share carousel images
  Future<void> shareCarouselImages() async {
    if (selectedImages.isEmpty) return;

    try {
      final List<XFile> files =
          selectedImages.map((file) => XFile(file.path)).toList();
      await Share.shareXFiles(
        files,
        text: 'Check out my Instagram carousel created with Instagram Tools!',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to share carousel: $e');
    }
  }

  // Clear selected images
  void clearImages() {
    if (selectedImages.isNotEmpty) {
      Get.defaultDialog(
        title: 'Clear All Images',
        middleText: 'Are you sure you want to remove all selected images?',
        textConfirm: 'Yes',
        textCancel: 'No',
        confirmTextColor: Colors.white,
        onConfirm: () {
          selectedImages.clear();
          isCarouselGenerated.value = false;
          Get.back();
        },
        onCancel: () => Get.back(),
      );
    }
  }

  // Clean up temporary files
  Future<void> _cleanupTempFiles() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String carouselPath = '${tempDir.path}/carousel_images';
      final Directory carouselDir = Directory(carouselPath);

      if (await carouselDir.exists()) {
        await carouselDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error cleaning up temp files: $e');
    }
  }
}
