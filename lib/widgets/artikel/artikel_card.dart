import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/pages/artikel/detail_artikel_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ArtikelCard extends StatelessWidget {
  final String label;
  final String title;
  final String image_path;
  final int articleId;
  final String content; // Menambahkan ID artikel
  const ArtikelCard({
    super.key,
    required this.label,
    required this.title,
    required this.image_path,
    required this.articleId,
    required this.content, // Menambahkan parameter ID artikel
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Kirim ID artikel ke DetailArtikelPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailArtikelPage(
                articleId: articleId,
                title: title,
                label: label,
                image_path: image_path,
                content: content),
          ),
        );
      },
      child: Container(
        // height: 116, // Memastikan tinggi sudah sesuai
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: neutral100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100, // Menambahkan height agar ukuran jelas
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias, // Agar radius diterapkan pada gambar
              child: CachedNetworkImage(
                imageUrl: image_path,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                  child: CircularProgressIndicator(value: downloadProgress.progress),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: neutral50,
                          borderRadius: BorderRadius.circular(64),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          label,
                          style: regularTS.copyWith(
                            fontSize: 10,
                            color: neutral600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: mediumTS.copyWith(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Read more',
                        style: mediumTS.copyWith(fontSize: 12, color: green700),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        IconsaxPlusLinear.arrow_right,
                        size: 20,
                        color: green700,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
