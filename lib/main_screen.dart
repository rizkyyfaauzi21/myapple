import 'dart:convert';
import 'dart:io';
import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/pages/account/profil_page.dart';
import 'package:apple_leaf/pages/artikel/artikel_page.dart';
import 'package:apple_leaf/pages/history/riwayat_page.dart';
import 'package:apple_leaf/pages/history/scan_page.dart';
import 'package:apple_leaf/pages/home/beranda_page.dart';
import 'package:apple_leaf/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apple_leaf/provider/imageScan_provider.dart';

final isUploadingProvider = StateProvider<bool>((ref) => false);

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  void updateIndex(int newIndex) {
    setState(() => _currentIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final userData = authState.userData;
    final List<Widget> pages = [
      BerandaPage(updateIndex: updateIndex),
      const RiwayatPage(),
      const ArtikelPage(),
      const ProfilPage(),
    ];

    return Scaffold(
      // BODY
      body: pages[_currentIndex],

      // FLOATING BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final isUploading = ref.watch(isUploadingProvider);

          return FloatingActionButton(
            onPressed: isUploading
                ? null
                : () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (image != null) {
                      final file = File(image.path);
                      try {
                        // Set loading state
                        ref.read(isUploadingProvider.notifier).state = true;

                        // Show loading dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(green700)),
                          ),
                        );

                        final result = await ref
                            .read(imageUploadProvider)
                            .handleImageUpload(file, context);

                        // Hide loading dialog
                        if (context.mounted) Navigator.pop(context);

                        // Navigate to ScanPage
                        if (context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ScanPage(
                                image: XFile(file.path),
                                title: result['category']['category'],
                                predictedLabel: result['predicted_label'],
                                category: result['category'],
                                userId: userData!['id'],
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        // Hide loading dialog
                        if (context.mounted) Navigator.pop(context);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Failed to upload image: $e")),
                          );
                        }
                      } finally {
                        // Reset loading state
                        ref.read(isUploadingProvider.notifier).state = false;
                      }
                    }
                  },
            backgroundColor: isUploading ? Colors.grey : green700,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(64)),
            ),
            child: Icon(
              isUploading ? Icons.hourglass_empty : IconsaxPlusLinear.camera,
              color: neutralWhite,
            ),
          );
        },
      ),

      // FLOATING BUTTON END

      // BOTTOM NAVBAR
      bottomNavigationBar: BottomAppBar(
        height: 72,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: neutral50,
          selectedItemColor: green700,
          unselectedItemColor: neutral400,
          selectedLabelStyle: regularTS.copyWith(fontSize: 12, color: green700),
          unselectedLabelStyle:
              regularTS.copyWith(fontSize: 12, color: neutral400),
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconsaxPlusLinear.home_2),
              activeIcon: Icon(IconsaxPlusBold.home_2),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsaxPlusLinear.clock_1),
              activeIcon: Icon(IconsaxPlusBold.clock),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsaxPlusLinear.note_2),
              activeIcon: Icon(IconsaxPlusBold.note_2),
              label: 'Artikel',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsaxPlusLinear.profile_circle),
              activeIcon: Icon(IconsaxPlusBold.profile_circle),
              label: 'Profil',
            ),
          ],
        ),
      ),
      // BOTTOM NAVBAR END
    );
  }
}
