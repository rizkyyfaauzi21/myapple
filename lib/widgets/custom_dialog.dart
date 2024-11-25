import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  const CustomDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: neutralWhite,
      surfaceTintColor: neutralWhite,
      titlePadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: neutral50,
        ),
        child: Column(
          children: [
            // Message Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: mediumTS.copyWith(fontSize: 18, color: neutralBlack),
            ),

            if (subtitle != null) ...[
              const SizedBox(height: 6),

              // Message subtitle
              Text(
                subtitle.toString(),
                textAlign: TextAlign.center,
                style: regularTS.copyWith(fontSize: 14, color: neutral400),
              ),
            ],
          ],
        ),
      ),

      // Actions (maybe some button)
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(12),
      actions: actions,
    );
  }
}
