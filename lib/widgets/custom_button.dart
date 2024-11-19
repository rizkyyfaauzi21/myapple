import 'package:flutter/material.dart';

import '../configs/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: green700,
          borderRadius: BorderRadius.circular(64),
        ),
        child: Text(
          text,
          style: mediumTS.copyWith(color: neutralWhite),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
