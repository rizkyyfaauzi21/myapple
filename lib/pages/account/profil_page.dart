import 'package:apple_leaf/pages/account/edit_password.dart';
import 'package:apple_leaf/pages/account/edit_profil.dart';
import 'package:apple_leaf/pages/login/auth_page.dart';
import 'package:apple_leaf/widgets/account/profil_menu.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../widgets/custom_button.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, title: 'Profil'),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // User Profile Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: neutral100,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rizky Fauzi',
                      style: mediumTS.copyWith(
                        fontSize: 16,
                        color: neutralBlack,
                      ),
                    ),
                    Text(
                      'rizkyfauzi01@gmail.com',
                      style: regularTS.copyWith(
                        color: neutral400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // List of Menu
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: neutral100, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Ubah Profil
                ProfilMenu(
                  icon: IconsaxPlusLinear.user_edit,
                  title: 'Ubah Profil',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditProfil()),
                  ),
                ),

                const Divider(height: 0, color: neutral100),

                // Ubah Password
                ProfilMenu(
                  icon: IconsaxPlusLinear.key,
                  title: 'Ubah Password',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditPassword()),
                  ),
                ),

                const Divider(height: 0, color: neutral100),

                // Logout
                ProfilMenu(
                  icon: IconsaxPlusLinear.logout,
                  iconColor: redBase,
                  title: 'Keluar',
                  onTap: () => handleLogout(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Ingin Keluar?',
        subtitle: 'Anda dapat masuk kembali kapan saja dengan menggunakan akun Anda.',
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  isDialogButton: true,
                  text: 'Keluar',
                  backgroundColor: redBase,
                  onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthPage()),
                    (route) => false,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: CustomButton(
                  isDialogButton: true,
                  text: 'Batal',
                  backgroundColor: neutralWhite,
                  borderColor: neutral100,
                  textColor: neutralBlack,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
