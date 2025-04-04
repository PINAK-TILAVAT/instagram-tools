import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:instapro/app_constants.dart';
import 'package:instapro/home_controller.dart';
import 'package:share_plus/share_plus.dart';

class GridMakerController extends GetxController {
  // Dependencies
  final HomeController homeController = Get.find<HomeController>();

  // Observables
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isProcessing = false.obs;
  final RxBool isGridGenerated = false.obs;
  final RxList<File> gridImages = <File>[].obs;
  final RxDouble progress = 0.0.obs;

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

  // Pick image from gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
      isGridGenerated.value = false;
      gridImages.clear();
    }
  }

  // Capture image with camera
  Future<void> captureImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
      isGridGenerated.value = false;
      gridImages.clear();
    }
  }

  // Generate 3x3 grid from the selected image
  Future<void> generateGrid() async {
    if (selectedImage.value == null) return;

    isProcessing.value = true;
    progress.value = 0.0;

    try {
      // Read the image
      final File imageFile = selectedImage.value!;
      final img.Image? originalImage = img.decodeImage(
        await imageFile.readAsBytes(),
      );

      if (originalImage == null) {
        Get.snackbar('Error', 'Failed to process image');
        isProcessing.value = false;
        return;
      }

      // Resize and crop the image to ensure 4:3 aspect ratio
      final int targetWidth = AppConstants.defaultImageWidth;
      final int targetHeight =
          (targetWidth * 3 / 4).round(); // 4:3 aspect ratio

      // Resize and crop to fit 4:3 aspect ratio
      final img.Image resizedImage = img.copyResize(
        originalImage,
        width: targetWidth,
        height: targetHeight,
        interpolation: img.Interpolation.cubic,
      );

      // Clear previous grid
      _cleanupTempFiles();
      gridImages.clear();

      // Calculate dimensions for each grid cell
      final int cellWidth = resizedImage.width ~/ 3;
      final int cellHeight = resizedImage.height ~/ 3;

      // Create directory for temporary files
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = '${tempDir.path}/grid_images';
      await Directory(tempPath).create(recursive: true);

      // Create 3x3 grid
      final int totalCells = 9;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          final int index = row * 3 + col;

          // Extract the cell from the image
          final img.Image cell = img.copyCrop(
            resizedImage,
            x: col * cellWidth,
            y: row * cellHeight,
            width: cellWidth,
            height: cellHeight,
          );

          // Save cell to temporary file
          final String cellPath = '$tempPath/cell_$index.jpg';
          final File cellFile = File(cellPath);
          await cellFile.writeAsBytes(img.encodeJpg(cell, quality: 95));

          // Add to grid images list
          gridImages.add(cellFile);

          // Update progress
          progress.value = (index + 1) / totalCells;
        }
      }

      // Decrement grid uses if not premium
      if (!homeController.isPremium.value) {
        await homeController.decrementGridUses();
      }

      isGridGenerated.value = true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate grid: $e');
    } finally {
      isProcessing.value = false;
    }
  }

  // Save grid images to gallery using image_gallery_saver
  Future<void> saveGridToGallery() async {
    if (gridImages.isEmpty) return;

    try {
      isProcessing.value = true;
      progress.value = 0.0;

      // Create a Pictures directory if it doesn't exist
      final directory = Directory(
        '${(await getExternalStorageDirectory())!.path}/Pictures/InstaPro',
      );
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final int totalImages = gridImages.length;
      int savedCount = 0;

      for (int i = 0; i < totalImages; i++) {
        final String fileName =
            'instagram_grid_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        final String filePath = '${directory.path}/$fileName';

        // Copy the file to Pictures directory
        await gridImages[i].copy(filePath);

        // Notify media scanner to make the image visible in gallery
        await SystemChannels.platform.invokeMethod(
          'MediaScanner.scanFile',
          filePath,
        );

        savedCount++;
        progress.value = (i + 1) / totalImages;
      }

      Get.snackbar(
        'Success',
        'Saved $savedCount/$totalImages grid images to Pictures/InstaPro',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to save grid: $e');
    } finally {
      isProcessing.value = false;
    }
  }

  // Share grid images
  Future<void> shareGridImages() async {
    if (gridImages.isEmpty) return;

    try {
      final List<XFile> files =
          gridImages.map((file) => XFile(file.path)).toList();
      await Share.shareXFiles(
        files,
        text: 'Check out my Instagram grid created with Instagram Tools!',
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to share grid: $e');
    }
  }

  // Clean up temporary files
  Future<void> _cleanupTempFiles() async {
    for (final File file in gridImages) {
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Error deleting temp file: $e');
      }
    }
  }
}
