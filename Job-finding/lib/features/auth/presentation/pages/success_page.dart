import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Successfully',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your password has been updated, please change your\npassword regularly to avoid this happening',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 64),
              Image.asset('lib/core/asset/successfull_image.png', height: 150),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('CONTINUE'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPurple.withOpacity(0.3),
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                ),
                child: const Text('BACK TO LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
