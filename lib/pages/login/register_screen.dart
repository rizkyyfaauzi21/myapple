import 'package:flutter/material.dart';

import '../../configs/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  bool passwordHidden = true;

  @override
  void dispose() {
    namaController.dispose();
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
        // Nama

        CustomForm(
          title: 'Nama',
          controller: emailController,
          keyboardType: TextInputType.name,
          hint: 'Masukkan nama Anda',
        ),

        const SizedBox(height: 12),

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

        const SizedBox(height: 24),

        CustomButton(
          onTap: () {},
          text: 'Daftar',
        )
      ],
    );
  }
}
