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
import 'package:http_parser/http_parser.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http; // Import HTTP package
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:apple_leaf/provider/imageScan_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final image =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (image != null) {
            final file = File(image.path);

            try {
              // Akses fungsi upload dari provider
              final result = await ref
                  .read(imageUploadProvider)
                  .handleImageUpload(file, context);

              // Pindah ke ScanPage dengan hasil prediksi
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ScanPage(
                      image: XFile(file.path), // Mengirim XFile ke ScanPage
                      title: result['predicted_label'], // Hasil prediksi label
                      predictedLabel: result['predicted_label'],
                      category: result['category'], // Data kategori
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
        backgroundColor: green700,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(64)),
        ),
        child: const Icon(
          IconsaxPlusLinear.camera,
          color: neutralWhite,
        ),
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
