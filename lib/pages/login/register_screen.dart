import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../configs/theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../provider/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  bool passwordHidden = true;
  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    final name = namaController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      isLoading = true;
    });

    await ref.read(authProvider.notifier).register(name, email, password);
    final authState = ref.read(authProvider);

    setState(() {
      isLoading = false;
    });

    if (authState.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authState.error!)),
      );
    } else {
      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil! Silakan masuk.')),
      );

      // Optionally, navigate to the login screen
      DefaultTabController.of(context)?.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Nama
        CustomForm(
          title: 'Nama',
          controller: namaController,
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

        isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomButton(
                onTap: handleRegister,
                text: 'Daftar',
              ),
      ],
    );
  }
}