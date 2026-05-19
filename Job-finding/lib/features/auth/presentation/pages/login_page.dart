import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../bloc/auth_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  void _onLogin() {
    context.read<AuthBloc>().add(
          LoginRequested(_emailController.text, _passwordController.text),
        );
  }

  void _onGoogleLogin() {
    context.read<AuthBloc>().add(LoginWithGoogleRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Success')));
             // context.go('/home'); // Define where to go after success
          } else if (state is AuthError) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 48),
                  _buildTextField('Email', _emailController, false, null),
                  const SizedBox(height: 16),
                  _buildTextField('Password', _passwordController, _obscurePassword, IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                           setState(() {
                             _obscurePassword = !_obscurePassword;
                           });
                        },
                      )),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            activeColor: AppColors.primary,
                            onChanged: (val) {
                              setState(() {
                                _rememberMe = val ?? false;
                              });
                            },
                          ),
                          const Text('Remember me', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                      TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        child: const Text('Forgot Password ?', style: TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (state is AuthLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ElevatedButton(
                      onPressed: _onLogin,
                      child: const Text('LOGIN'),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPurple.withOpacity(0.3),
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                    ),
                    icon: _buildGoogleIcon(),
                    label: const Text('SIGN IN WITH GOOGLE'),
                    onPressed: _onGoogleLogin,
                  ),
                  const SizedBox(height: 32),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Text("You don't have an account yet? ", style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                       GestureDetector(
                         onTap: () => context.push('/signup'),
                         child: const Text('Sign Up', style: TextStyle(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                       )
                     ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool obscureText, Widget? suffixIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: 'Enter your ${label.toLowerCase()}',
          ),
        ),
      ],
    );
  }
  
  Widget _buildGoogleIcon() {
    return Image.asset('lib/core/asset/google.png', height: 24);
  }
}
