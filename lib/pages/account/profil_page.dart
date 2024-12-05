import 'package:apple_leaf/pages/account/edit_password.dart';
import 'package:apple_leaf/pages/account/edit_profil.dart';
import 'package:apple_leaf/pages/login/auth_page.dart';
import 'package:apple_leaf/widgets/account/profil_menu.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_button.dart';
import '../../provider/auth_provider.dart';

class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Get user data from auth state
    final userData = authState.userData;

    // If userData is null, show a loading indicator or default values
    final userName = userData?['name'] ?? 'Loading...';
    final userEmail = userData?['email'] ?? 'Loading...';

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
                      userName,
                      style: mediumTS.copyWith(
                        fontSize: 16,
                        color: neutralBlack,
                      ),
                    ),
                    Text(
                      userEmail,
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
                  onTap: () => handleLogout(context, ref),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogout(BuildContext context, WidgetRef ref) async {
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
                  onTap: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    // Perform logout
                    final authNotifier = ref.read(authProvider.notifier);
                    await authNotifier.logout();
                    // Navigate to AuthPage
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const AuthPage()),
                      (route) => false,
                    );
                  },
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
                  onTap: () => Navigator.of(context).pop(), // Close the dialog
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}