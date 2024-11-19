import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/history/listPenyakit_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
// import 'package:apple_leaf/widgets/home/custom_card.dart';

class ListpenyakitPage extends StatelessWidget {
  final String? label;

  const ListpenyakitPage({
    Key? key,
    required this.label, // Pastikan label diterima
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: neutralWhite,
          surfaceTintColor: neutralWhite,
          titleSpacing: 0,
          title: Text(
            label.toString(),
            style: mediumTS.copyWith(fontSize: 20),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: neutralWhite),
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
                    child: Column(
                      children: [
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        listPenyakitCard(
                          image: 'assets/images/daun_article.png',
                          title: 'Fire Blight',
                          date: '10 November 2024',
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
