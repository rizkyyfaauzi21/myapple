import 'package:flutter/material.dart';

import '../../configs/theme.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: neutral100)),
              ),
              child: Column(
                children: [
                  const ImageIcon(
                    AssetImage('assets/icons/app_icon.png'),
                    color: green600,
                    size: 40,
                  ),

                  const SizedBox(height: 20),

                  // Greeting messages
                  Text(
                    'Welcome to MyApple!',
                    style: semiboldTS.copyWith(fontSize: 24, color: neutralBlack),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sign In or Sign Up to access your account',
                    style: regularTS.copyWith(color: neutralBlack),
                  ),

                  const SizedBox(height: 16),

                  // Buat Akun dan Masuk (Tab Bar)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(64),
                      color: neutral50,
                    ),
                    child: TabBar(
                      indicatorPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      labelStyle: mediumTS.copyWith(fontSize: 14, color: neutralWhite),
                      unselectedLabelStyle: mediumTS.copyWith(fontSize: 14, color: neutral400),
                      indicator: BoxDecoration(
                        color: green700,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      splashBorderRadius: BorderRadius.circular(100),
                      dividerHeight: 0,
                      tabs: const [
                        Tab(text: 'Daftar'),
                        Tab(text: 'Masuk'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Buat Akun dan Masuk (Page)
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  RegisterScreen(),
                  LoginScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}