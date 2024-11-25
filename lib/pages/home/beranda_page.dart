import 'package:apple_leaf/widgets/home/beranda_pindai_card.dart';
import 'package:apple_leaf/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';

class BerandaPage extends StatelessWidget {
  final Function(int) updateIndex;
  const BerandaPage({super.key, required this.updateIndex});

  @override
  Widget build(BuildContext context) {
    bool isEventEmpty = false;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => updateIndex(3),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/1.jpg'),
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
                  'Rizky Fauzi!',
                  style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
                )
              ],
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          // Pindai
          BerandaPindaiCard(
            onScan: () {},
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
          isEventEmpty
              ? Column(
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
              : const Padding(
                  padding: EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      CustomCard(
                        label: 'Scrab',
                        waktuScan: '1 hari yang lalu',
                        image: 'assets/images/daun_article.png',
                      ),
                      CustomCard(
                        label: 'Fire Blight',
                        waktuScan: '1 hari yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
