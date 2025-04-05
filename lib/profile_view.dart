import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_colors.dart';

import 'package:instapro/auth_controller.dart';

class ProfileView extends GetView<AuthController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Profile Avatar
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: Obx(
                    () => Text(
                      controller.userName.value.isNotEmpty
                          ? controller.userName.value[0].toUpperCase()
                          : 'U',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // User Name
              Obx(
                () => Text(
                  controller.userName.value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Phone Number
              Obx(
                () => Text(
                  controller.phoneNumber.value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

              // Usage Information Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Usage Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grid Maker Uses Remaining:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '5',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Carousel Maker Uses Remaining:',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            '3',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Sign Out Button
              ElevatedButton.icon(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Log Out',
                    middleText: 'Are you sure you want to log out?',
                    textConfirm: 'Log Out',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back();
                      controller.logout();
                    },
                    onCancel: () => Get.back(),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  foregroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
