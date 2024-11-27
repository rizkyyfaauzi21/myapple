import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            text: 'Simpan',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
