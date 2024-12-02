import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Reset Password'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Title
          Text(
            'Ingin reset password?',
            style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Masukkan email Anda untuk mendapatkan link reset password.',
            style: regularTS.copyWith(color: neutral400),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 34),

          // Email
          CustomForm(
            title: 'Email',
            controller: emailController,
            hint: 'johndoe@gmail.com',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 24),

          // Konfirmasi Button
          CustomButton(
            text: 'Konfirmasi',
            onTap: () => showDialog(
              context: context,
              builder: (context) => CustomDialog(
                title: 'Email berhasil terkirim!',
                subtitle: 'Silakan cek tautan yang kami kirim ke ${emailController.text}.',
                actions: [
                  CustomButton(
                    onTap: () => Navigator.of(context).pop(),
                    text: 'Oke',
                    isDialogButton: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}