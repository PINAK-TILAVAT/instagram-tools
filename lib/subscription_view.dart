import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instapro/app_colors.dart';
import 'package:instapro/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade to Premium'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Premium banner
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.instagramGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Instagram Tools Premium',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Unlock all features and remove limitations',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Features included
                Text(
                  'Premium Features',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                _buildFeatureItem(
                  context: context,
                  icon: Icons.grid_3x3,
                  text: 'Unlimited Grid Splits',
                ),
                _buildFeatureItem(
                  context: context,
                  icon: Icons.high_quality,
                  text: 'High Quality Exports',
                ),
                _buildFeatureItem(
                  context: context,
                  icon: Icons.view_carousel,
                  text: 'Unlimited Carousel Posts',
                ),
                _buildFeatureItem(
                  context: context,
                  icon: Icons.auto_awesome,
                  text: 'Priority Updates & Features',
                ),
                _buildFeatureItem(
                  context: context,
                  icon: Icons.no_photography,
                  text: 'No Watermarks',
                ),

                const SizedBox(height: 30),

                // Subscription options
                Text(
                  'Choose Your Plan',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // Monthly plan
                _buildSubscriptionOption(
                  context: context,
                  title: 'Monthly',
                  price: '\$4.99',
                  description: 'Billed monthly',
                  isPopular: false,
                  onTap: () {
                    controller.selectedPlan.value = 'monthly';
                    Get.forceAppUpdate();
                  },
                ),

                const SizedBox(height: 12),

                // Yearly plan
                _buildSubscriptionOption(
                  context: context,
                  title: 'Yearly',
                  price: '\$39.99',
                  description: 'Billed annually (Save 33%)',
                  isPopular: true,
                  onTap: () {
                    controller.selectedPlan.value = 'yearly';
                    Get.forceAppUpdate();
                  },
                ),

                const SizedBox(height: 30),

                // Upgrade button
                ElevatedButton(
                  onPressed:
                      () => controller.subscribeToPlan(
                        controller.selectedPlan.value,
                      ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Upgrade Now',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Restore purchases & Terms
                Center(
                  child: TextButton(
                    onPressed: controller.restorePurchases,
                    child: const Text('Restore Purchases'),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Subscriptions will be charged to your payment method through your App Store or Google Play account. Your subscription will automatically renew unless canceled at least 24 hours before the end of the current period.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOption({
    required BuildContext context,
    required String title,
    required String price,
    required String description,
    required bool isPopular,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isPopular
                    ? AppColors.primary.withOpacity(0.1)
                    : Theme.of(context).cardColor,
            border: Border.all(
              color:
                  controller.selectedPlan.value ==
                          (isPopular ? 'yearly' : 'monthly')
                      ? AppColors.primary
                      : isPopular
                      ? AppColors.primary.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.3),
              width:
                  controller.selectedPlan.value ==
                          (isPopular ? 'yearly' : 'monthly')
                      ? 2
                      : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Text(
                        price,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isPopular)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Best Value',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              // if (isPopular)
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: Transform.translate(
              //     offset: const Offset(5, -10),
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 8,
              //         vertical: 4,
              //       ),
              //       decoration: BoxDecoration(
              //         color: AppColors.primary,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //       child: Text(
              //         'Best Value',
              //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
