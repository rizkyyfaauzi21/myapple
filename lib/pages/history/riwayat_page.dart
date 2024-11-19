import 'package:apple_leaf/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutralWhite,
        surfaceTintColor: neutralWhite,
        title: Text(
          "Riwayat",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Ikon berwarna hitam
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(color: neutralWhite),
        child: ListView(
          children: [
            const Divider(
              height: 1,
              color: neutral100,
            ),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: neutral50,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconsaxPlusLinear.search_normal_1,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Cari riwayat',
                                border: InputBorder.none,
                                hintStyle: mediumTS.copyWith(color: neutral400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      CustomCard(
                        label: 'RIZKY HITAM',
                        waktuScan: 'Terakhir DIHITAMKAN 1 minggu yang lalu',
                        image: 'assets/images/1.jpg',
                      ),
                      CustomCard(
                        label: 'Apel 1',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 2',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 3',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 4',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 5',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 6',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 7',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 8',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 9',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 10',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 11',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                      CustomCard(
                        label: 'Apel 12',
                        waktuScan: 'Terakhir discan 1 minggu yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
