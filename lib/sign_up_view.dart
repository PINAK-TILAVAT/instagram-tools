import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_colors.dart';
import 'package:instapro/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Logo or Image Placeholder
                Container(
                  // height: 180,
                  // decoration: BoxDecoration(
                  //   color: Theme.of(context).cardColor,
                  //   borderRadius: BorderRadius.circular(16),
                  // ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/signup.png', // Replace with your image path
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Name Input Field
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Name',
                    hintText: 'John Doe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  onChanged: controller.validateName,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 16),

                // Phone Input Field
                TextFormField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: controller.validatePhone,
                ),

                const SizedBox(height: 16),

                // Privacy Notice
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Text(
                    'We don\'t share contact with anyone',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // Action Buttons
                Row(
                  children: [
                    // Skip Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.skipLogin,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Skip',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Generate OTP Button
                    Expanded(
                      flex: 2,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed:
                              controller.isFormValid &&
                                      !controller.isLoading.value
                                  ? controller.generateOTP
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Text('Generate OTP'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
