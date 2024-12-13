import 'package:apple_leaf/pages/history/list_penyakit_page.dart';
import 'package:flutter/material.dart';
import '../../configs/theme.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final String waktuScan;
  final String image;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.label,
    required this.waktuScan,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: neutral50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: neutral100),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.asset(
              image.toString(),
              height: 128,
              width: MediaQuery.of(context).size.width / 2 - 20,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: mediumTS.copyWith(color: neutralBlack),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    waktuScan,
                    style: regularTS.copyWith(fontSize: 12, color: neutral400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
