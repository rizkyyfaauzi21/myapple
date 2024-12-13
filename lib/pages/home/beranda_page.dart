import 'dart:io';

import 'package:apple_leaf/pages/history/scan_page.dart';
import 'package:apple_leaf/provider/imageScan_provider.dart';
import 'package:apple_leaf/widgets/home/beranda_pindai_card.dart';
import 'package:apple_leaf/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../provider/auth_provider.dart';
import 'package:apple_leaf/provider/apple_service.dart';
import 'package:apple_leaf/provider/history_service.dart';

class BerandaPage extends ConsumerWidget {
  final Function(int) updateIndex;
  const BerandaPage({super.key, required this.updateIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEventEmpty = false;
    String? profilePicturePath;
    final authNotifier = ref.read(authProvider.notifier);
    final baseImageUrl = authNotifier.baseImageUrl;

    // Access the authentication state
    final authState = ref.watch(authProvider);
    final userData = authState.userData;

    // Get the user's name, or use a default if it's null
    final userName = userData?['name'] ?? 'Pengguna';
    profilePicturePath = userData?['profile_picture'];

    final userId = userData?['id'].toString();
    final appleState = ref.watch(appleProvider(userId ?? ''));
    final historyState = ref.watch(appleHistoryProvider(userId ?? ''));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => updateIndex(3),
              child: CircleAvatar(
                backgroundImage: profilePicturePath != null
                    ? NetworkImage('$baseImageUrl/storage/$profilePicturePath')
                    : const AssetImage('assets/images/icon.jpg'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Halo,',
                  style: regularTS.copyWith(
                    fontSize: 14,
                    color: neutral400,
                  ),
                ),
                Text(
                  '$userName!',
                  style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
                ),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          // Pindai
          BerandaPindaiCard(
            // onScan: () {},
            onScan: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
            final file = File(image.path);

            try {
              // Akses fungsi upload dari provider
              final result = await ref.read(imageUploadProvider).handleImageUpload(file, context);

              // Pindah ke ScanPage dengan hasil prediksi
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ScanPage(
                        image: XFile(file.path),  // Mengirim XFile ke ScanPage
                        title: result['predicted_label'],  // Hasil prediksi label
                        predictedLabel: result['predicted_label'],
                        category: result['category'],  // Data kategori
                        userId: userData!['id'],
                      );
                    },
                  ),
                );
            } catch (e) {
              print("Error: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to upload image: $e")),
              );
            }
          }
            },
          ),

          const SizedBox(height: 16),

          // Riwayat
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Riwayat terbaru',
              style: mediumTS.copyWith(fontSize: 20, color: neutralBlack),
            ),
          ),
          if (appleState.apples.isEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/icons/EmptyState.png',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Belum ada riwayat',
                  style: mediumTS.copyWith(fontSize: 14, color: neutral400),
                )
              ],
            )
          else
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: appleState.apples.take(2).map((apple) {
                  return CustomCard(
                    appleId: apple['id'].toString(),
                    label: apple['nama_apel'] ?? 'Unknown Apple',
                    waktuScan: 'Terakhir scan 1 minggu yang lalu',
                    image: apple['image_url'] ?? 'assets/images/apple_card.png',
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
