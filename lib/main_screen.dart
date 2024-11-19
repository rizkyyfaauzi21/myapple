import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/pages/account/profil_page.dart';
import 'package:apple_leaf/pages/artikel/artikel_page.dart';
import 'package:apple_leaf/pages/history/riwayat_page.dart';
import 'package:apple_leaf/pages/home/beranda_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void updateIndex(int newIndex) {
    setState(() => _currentIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: neutral50,
        selectedItemColor: green700,
        unselectedItemColor: neutral400,
        selectedLabelStyle: regularTS.copyWith(fontSize: 12, color: green700),
        unselectedLabelStyle: regularTS.copyWith(fontSize: 12, color: neutral400),
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
      // BOTTOM NAVBAR END
    );
  }
}
