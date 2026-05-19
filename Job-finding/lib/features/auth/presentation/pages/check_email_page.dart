import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class CheckEmailPage extends StatelessWidget {
  final String email;

  const CheckEmailPage({super.key, required this.email});

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
                'Check Your Email',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                'We have sent the reset password to the email address\n$email',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 64),
              Image.asset('lib/core/asset/checkemail_image.png', height: 150),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  // Usually opens mail app or navigates to next mock success page
                  context.push('/success');
                },
                child: const Text('OPEN YOUR EMAIL'),
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
              const SizedBox(height: 32),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text("You have not received the email? ", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                   GestureDetector(
                     onTap: () {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resend email requested')));
                     },
                     child: const Text('Resend', style: TextStyle(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                   )
                 ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
