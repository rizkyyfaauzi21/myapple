import 'package:flutter/material.dart';

import '../configs/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final bool isDialogButton;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor = green700,
    this.borderColor,
    this.textColor = neutralWhite,
    this.isDialogButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: isDialogButton
            ? const EdgeInsets.all(12)
            : const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(64),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Text(
          text,
          style: mediumTS.copyWith(color: textColor, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
