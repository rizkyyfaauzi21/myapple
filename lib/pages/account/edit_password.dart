import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/auth_provider.dart';
import '../login/auth_page.dart';

class EditPassword extends ConsumerStatefulWidget {
  const EditPassword({super.key});

  @override
  ConsumerState<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends ConsumerState<EditPassword> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool currentPasswordHidden = true;
  bool newPasswordHidden = true;
  bool confirmPasswordHidden = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: customAppBar(context, title: 'Ubah Password'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Current Password Input
          CustomForm(
            title: 'Password Saat Ini',
            hint: 'Masukkan password saat ini',
            obscureText: currentPasswordHidden,
            controller: currentPasswordController,
            isPassword: true,
            onTap: () {
              setState(() {
                currentPasswordHidden = !currentPasswordHidden;
              });
            },
          ),
          const SizedBox(height: 16),

          // New Password Input
          CustomForm(
            title: 'Password Baru',
            hint: 'Masukkan password baru',
            obscureText: newPasswordHidden,
            controller: newPasswordController,
            isPassword: true,
            onTap: () {
              setState(() {
                newPasswordHidden = !newPasswordHidden;
              });
            },
          ),
          const SizedBox(height: 16),

          // Confirm New Password Input
          CustomForm(
            title: 'Konfirmasi Password Baru',
            hint: 'Masukkan kembali password baru',
            obscureText: confirmPasswordHidden,
            controller: confirmPasswordController,
            isPassword: true,
            onTap: () {
              setState(() {
                confirmPasswordHidden = !confirmPasswordHidden;
              });
            },
          ),
          const SizedBox(height: 24),

          // Save Button
          CustomButton(
            text: isLoading ? 'Menyimpan...' : 'Simpan',
            onTap: isLoading ? null : handleSave,
          ),

          // Show error message if any
          // if (authState.error != null)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 16),
          //     child: Text(
          //       authState.error!,
          //       style: const TextStyle(color: Colors.red),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
        ],
      ),
    );
  }

  Future<void> handleSave() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validate inputs
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom harus diisi.')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password baru dan konfirmasi tidak cocok.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final authNotifier = ref.read(authProvider.notifier);
    final errorMessage = await authNotifier.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: confirmPassword,
    );

    setState(() {
      isLoading = false;
    });

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password berhasil diperbarui.')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthPage()),
        (route) => false,
      );
    }
  }
}