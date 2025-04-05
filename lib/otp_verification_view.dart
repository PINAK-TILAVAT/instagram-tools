import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instapro/app_colors.dart';

import 'package:instapro/otp_input_field.dart';
import 'package:instapro/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            // OTP Input Field
            Text(
              'Enter Your OTP',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // OTP boxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Obx(
                () => OtpInputField(
                  controller: controller.otpController,
                  hasError: controller.hasError.value,
                  onCompleted: (isComplete) {
                    // Auto-submit when all digits are entered
                    if (isComplete && !controller.isLoading.value) {
                      controller.verifyOTP();
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Resend OTP Text
            Obx(
              () => GestureDetector(
                onTap:
                    controller.resendTime.value <= 0
                        ? controller.resendOTP
                        : null,
                child: Text(
                  controller.resendTime.value > 0
                      ? 'Resend OTP in ${controller.resendTime.value} seconds'
                      : 'Resend OTP',
                  style: TextStyle(
                    color:
                        controller.resendTime.value <= 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                    decoration:
                        controller.resendTime.value <= 0
                            ? TextDecoration.underline
                            : TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const Spacer(),

            // Verify Button
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.verifyOTP,
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
                        : const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
