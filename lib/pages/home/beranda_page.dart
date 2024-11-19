import 'package:apple_leaf/widgets/home/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';

class BerandaPage extends StatelessWidget {
  final Function(int) updateIndex;
  const BerandaPage({super.key, required this.updateIndex});

  final isEventEmpty = false;

  @override
  Widget build(BuildContext context) {
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
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/apple_background.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(153, 0, 0, 0),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pindai Kesehatan\nPohon Apelmu!',
                          style: mediumTS.copyWith(
                            fontSize: 20,
                            color: neutralWhite,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              width: MediaQuery.of(context).size.width / 2.45,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(64),
                                color: const Color(0xffD3F3FA),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const ImageIcon(
                                    AssetImage('assets/icons/scan.png'),
                                    color: neutralBlack,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'Pindai',
                                    style: mediumTS.copyWith(
                                      fontSize: 16,
                                      color: neutralBlack,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Riwayat terbaru',
              style: mediumTS.copyWith(
                fontSize: 20,
                color: neutralBlack,
              ),
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
                      style: mediumTS.copyWith(
                        fontSize: 14,
                        color: neutral400,
                      ),
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      CustomCard(
                        label: 'Jomok Stadium 10',
                        waktuScan: '1 hari yang lalu',
                        image: 'assets/images/1.jpg',
                      ),
                      CustomCard(
                        label: 'Fire Blight',
                        waktuScan: '1 hari yang lalu',
                        image: 'assets/images/apple_card.png',
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
