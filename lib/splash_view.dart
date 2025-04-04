import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_constants.dart';
import 'package:instapro/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFE1306C), Color(0xFFC13584), Color(0xFF833AB4)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Simple fade-in text
              FadeTransition(
                opacity: controller.fadeAnimation,
                child: Image.asset(
                  'assets/images/spleshlogo.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 40),

              // Loading indicator
              SizedBox(
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.8),
                    ),
                    minHeight: 6,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Version number
              Text(
                'v${AppConstants.appVersion}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
