import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/artikel/artikel_card.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: mainAppBar(context, title: 'Artikel'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 12,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ArtikelCard(
              image: 'assets/images/daun_article.png',
              label: 'Hama & Penyakit',
              title: 'Virus Bercak Daun Klorosis Apel',
            );
          }
          return ArtikelCard(
            image: 'assets/images/apple_card.png',
            label: 'Hama & Penyakit',
            title: '$index Penyakit Busuk Buah Apel: Penyebab, Gejala, dan Pencegahan',
          );
        },
      ),
    );
  }
}
