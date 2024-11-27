import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/configs/theme.dart';

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
