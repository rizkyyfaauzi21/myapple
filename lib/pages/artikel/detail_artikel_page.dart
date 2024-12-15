import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';

class DetailArtikelPage extends StatelessWidget {
  final String title;
  final String label;
  final String image_path;
  final String content;
  const DetailArtikelPage(
      {super.key,
      required this.title,
      required int articleId,
      required this.label,
      required this.image_path,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: customAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Image of Artikel
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl:
                    image_path, // Use Image.asset or Image.network depending on the source of the image
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Title of Artikel
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 2),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: mediumTS.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: regularTS.copyWith(
                        fontSize: 12,
                        color: neutral400,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Article
          Text(
            content,
            style: regularTS.copyWith(color: neutralBlack),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
