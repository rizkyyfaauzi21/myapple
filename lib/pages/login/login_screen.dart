// File: lib/pages/login/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../configs/theme.dart';
import '../../main_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../provider/auth_provider.dart';
import 'forgot_password_page.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  bool passwordHidden = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      isLoading = true;
    });

    await ref.read(authProvider.notifier).login(email, password);
    final authState = ref.read(authProvider);

    setState(() {
      isLoading = false;
    });

    if (authState.token != null) {
      // Access user data if needed
      final userData = authState.userData;
      print('User Data: $userData');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    } else if (authState.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authState.error!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Email
        CustomForm(
          title: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          hint: 'Masukkan email Anda',
        ),

        const SizedBox(height: 12),

        // Password
        CustomForm(
          title: 'Password',
          controller: passwordController,
          hint: 'Masukkan password Anda',
          isPassword: true,
          obscureText: passwordHidden,
          onTap: () => setState(() => passwordHidden = !passwordHidden),
        ),

        const SizedBox(height: 8),

        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
              );
            },
            style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(green100),
            ),
            child: Text(
              'Lupa Password?',
              style: mediumTS.copyWith(color: green700),
              textAlign: TextAlign.end,
            ),
          ),
        ),

        const SizedBox(height: 12),

        isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomButton(
                onTap: handleLogin,
                text: 'Masuk',
              ),
      ],
    );
  }
}
