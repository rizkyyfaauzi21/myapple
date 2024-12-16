import 'package:apple_leaf/pages/history/list_penyakit_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../configs/theme.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final String waktuScan;
  final String image;
  final String appleId;

  const CustomCard({
    super.key,
    required this.label,
    required this.waktuScan,
    required this.image,
    required this.appleId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth - (12 * 3)) / 2; // Total padding space is 36 (12 * 3)

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ListPenyakitPage(label: label, appleId: appleId),
        ),
      ),
      child: Container(
        width: cardWidth,
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
            SizedBox(
              height: 126,
              width: cardWidth,
              child: image.startsWith('http') || image.startsWith('https')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/apple_card.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
