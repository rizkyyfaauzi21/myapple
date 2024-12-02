// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/login/auth_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apple Leaf',
      theme: _buildTheme(),
      home: const AuthPage(),
    );
  }

  // Modularisasi tema untuk kemudahan perawatan
  ThemeData _buildTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Inter',
    );
  }
}