import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';

class DetailPenyakitTab extends StatelessWidget {
  final String text;
  const DetailPenyakitTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        style: regularTS.copyWith(color: neutralBlack),
      ),
    );
  }
}
