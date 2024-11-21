import 'package:apple_leaf/pages/account/edit_password.dart';
import 'package:apple_leaf/pages/account/edit_profil.dart';
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
      appBar: AppBar(
        title: Text(
          'Profil',
          style: mediumTS.copyWith(
            fontSize: 20,
            color: neutralBlack,
          ),
        ),
        toolbarHeight: 52,
      ),
      body: ListView(
        children: [
          const Divider(
            height: 1,
            color: neutral100,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
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
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: neutral100,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ProfilMenu(
                  icon: IconsaxPlusLinear.user_edit,
                  title: 'Ubah Profil',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditProfil()),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: neutral100,
                ),
                ProfilMenu(
                  icon: IconsaxPlusLinear.key,
                  title: 'Ubah Password',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const EditPassword()),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: neutral100,
                ),
                ProfilMenu(
                  icon: IconsaxPlusLinear.logout,
                  iconColor: redBase,
                  title: 'Keluar',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: 'Ingin Keluar?',
                      subtitle:
                          'Anda dapat masuk kembali kapan saja dengan menggunakan akun Anda.',
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                isDialogButton: true,
                                text: 'Keluar',
                                backgroundColor: redBase,
                                onTap: () {},
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilMenu extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback? onTap;
  const ProfilMenu({
    super.key,
    required this.icon,
    this.iconColor = neutralBlack,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: mediumTS.copyWith(
                fontSize: 16,
                color: iconColor,
              ),
            ),
            const Spacer(),
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}
