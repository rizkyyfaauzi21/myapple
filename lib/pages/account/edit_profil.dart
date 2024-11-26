import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/auth_provider.dart';

class EditProfil extends ConsumerStatefulWidget {
  const EditProfil({super.key});

  @override
  ConsumerState<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends ConsumerState<EditProfil> {
  late TextEditingController namaController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    final userData = authState.userData;

    namaController = TextEditingController(text: userData?['name'] ?? '');
    emailController = TextEditingController(text: userData?['email'] ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: customAppBar(context, title: 'Ubah Profil'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Foto Profil dengan ikon edit
          const Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                  backgroundColor: neutral100,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: green700,
                  child: Icon(IconsaxPlusLinear.edit, color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Input untuk Nama
          CustomForm(
            title: 'Nama',
            hint: 'John Doe',
            controller: namaController,
          ),

          const SizedBox(height: 16),
          // Input untuk Email
          CustomForm(
            title: 'Email',
            hint: 'johndoe@gmail.com',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 24),

          // Tombol Simpan
          CustomButton(
            text: isLoading ? 'Menyimpan...' : 'Simpan',
            onTap: isLoading ? null : handleSave,
          ),

          // Show error message if any
          if (authState.error != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                authState.error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> handleSave() async {
    final name = namaController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan Email tidak boleh kosong.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final authNotifier = ref.read(authProvider.notifier);
    final errorMessage = await authNotifier.updateProfile(
      name: name,
      email: email,
    );

    setState(() {
      isLoading = false;
    });

    if (errorMessage != null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui.')),
      );
    }
  }
}
