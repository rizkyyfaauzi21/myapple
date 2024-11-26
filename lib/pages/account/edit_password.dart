import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Ubah Password'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Input untuk Password
          CustomForm(
            title: 'Password Baru',
            hint: 'Masukkan password baru',
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 24),

          // Konfirmasi Password
          CustomForm(
            title: 'Konfirmasi Password',
            hint: 'Masukkan konfirmasi password',
            obscureText: true,
            controller: confirmPasswordController,
          ),

          const SizedBox(height: 24),

          // Tombol Simpan
          CustomButton(
            text: 'Konfirmasi',
            onTap: () {},
          )
        ],
      ),
    );
  }
}