import 'package:flutter/material.dart';

import '../../configs/theme.dart';
import '../../main_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  bool passwordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
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

        const SizedBox(height: 16),

        Text(
          'Lupa Password?',
          style: mediumTS.copyWith(color: green700),
          textAlign: TextAlign.end,
        ),

        const SizedBox(height: 24),

        CustomButton(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          },
          text: 'Masuk',
        )
      ],
    );
  }
}
