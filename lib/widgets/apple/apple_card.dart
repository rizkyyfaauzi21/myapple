import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AppleCard extends StatelessWidget {
  final String imagePath;
  final String appleName;
  final String lastScan;

  // Constructor
  const AppleCard({
    super.key,
    required this.imagePath,
    required this.appleName,
    required this.lastScan,
  });

  @override
  Widget build(BuildContext context) {
    final imagepath = imagePath;
    return Row(
      children: [
        // Container(
        //   height: 60,
        //   width: 60,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     image: DecorationImage(
        //       image: NetworkImage(imagePath), // Menggunakan URL lengkap untuk gambar
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),

        Container(
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                8), // Pastikan sudutnya sesuai dengan BoxDecoration
            child: CachedNetworkImage(
              imageUrl:
                  // 'http://10.0.2.2:8000/storage/images/apples/e28a69ae-f5dd-4245-804c-e7a47cdc27b35115912485236124386.jpg',
                  imagepath,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appleName,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black), // Sesuaikan gaya teks
            ),
            const SizedBox(height: 2),
            Text(
              lastScan,
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey), // Sesuaikan gaya teks
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(IconsaxPlusLinear.add_circle),
        ),
      ],
    );
  }
}
