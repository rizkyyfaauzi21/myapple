import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Password',
          style: mediumTS.copyWith(
            fontSize: 20,
            color: neutralBlack,
          ),
        ),
        titleSpacing: 0,
        toolbarHeight: 42,
        leading: IconButton(
          icon: const Icon(
            IconsaxPlusLinear.arrow_left,
            color: neutralBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            color: neutral100,
            height: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Input untuk Password
          CustomForm(
            title: 'Password Baru',
            obscureText: true,
            hint: 'Masukkan password baru',
          ),
          const SizedBox(height: 24),

          // Konfirmasi Password

          CustomForm(
            title: 'Konfirmasi Password',
            obscureText: true,
            hint: 'Masukkan konfirmasi password',
          ),

          const SizedBox(height: 40),

          // Tombol Simpan
          CustomButton(
            text: 'Simpan',
            onTap: () {},
          )
        ],
      ),
    );
  }
}
