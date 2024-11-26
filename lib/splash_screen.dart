import 'dart:async';
import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/pages/login/auth_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Durations.extralong4, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageIcon(
              AssetImage('assets/icons/app_icon.png'),
              size: 70,
              color: neutralWhite,
            ),
            const SizedBox(height: 16),
            Text(
              'MyApple',
              style: mediumTS.copyWith(fontSize: 28, color: neutralWhite),
            ),
          ],
        ),
      ),
    );
  }
}
