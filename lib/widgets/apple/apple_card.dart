import 'dart:io';

import 'package:apple_leaf/provider/scan_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AppleCard extends ConsumerWidget {
  final String appleId;
  final String userId;
  final String imagePath;
  final String appleName;
  final String lastScan;
  final XFile scanImagePath;
  final String diseaseInfoId;

  const AppleCard({
    super.key,
    required this.appleId,
    required this.userId,
    required this.imagePath,
    required this.appleName,
    required this.lastScan,
    required this.scanImagePath,
    required this.diseaseInfoId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imagePath,
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
          onTap: () async {
            // Mendapatkan ScanNotifier dari provider
            // Ganti sesuai penyakit yang terdeteksi
            final scanNotifier = ref.read(scanNotifierProvider.notifier);
            //buatkan scan date
            final scanDate = DateTime.now().toIso8601String();
            try {
              // Simpan diagnosis
              await scanNotifier.saveDiagnosis(
                appleId: appleId,
                userId: userId,
                scanDate: scanDate,
                imagePath: scanImagePath.path,
                diseaseInfoId: diseaseInfoId,
              );

              // Tampilkan notifikasi sukses
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('History berhasil ditambahkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
              }
            } catch (e) {
              // Tampilkan notifikasi error
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gagal menambahkan history: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pop();
              }
            }
          },
          child: const Icon(IconsaxPlusLinear.add_circle),
        ),
      ],
    );
  }
}
