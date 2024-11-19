import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/artikel/arikel_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutralWhite,
        surfaceTintColor: neutralWhite,
        title: Text(
          'Artikel',
          style: mediumTS.copyWith(
            fontSize: 20,
            color: neutralBlack,
          ),
        ),
        toolbarHeight: 52,
      ),
      body: Container(
        decoration: BoxDecoration(color: neutralWhite),
        child: ListView(
          children: [
            const Divider(
              height: 1,
              color: neutral100,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                // color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: neutral100,
                    width: 1, // Ketebalan garis
                  ),
                ),
              ),
              child: const Column(
                children: [
                  artikelCard(
                    image: 'assets/images/daun_article.png',
                    label: 'Hama & Penyakit',
                    title: 'Virus Bercak Daun Klorosis Apel',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
                  ),
                  SizedBox(height: 12),
                  artikelCard(
                    image: 'assets/images/apple_card.png',
                    label: 'Hama & Penyakit',
                    title: 'Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
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
