import 'package:flutter/material.dart';
import 'package:apple_leaf/configs/theme.dart';

class DetailArtikelPage extends StatelessWidget {
  final String title;

  const DetailArtikelPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: neutralWhite,
        surfaceTintColor: neutralWhite,
        // title: const Text('Detail Artikel'),
      ),
      body: ListView(
        children: [
          const Divider(
            height: 1,
            color: neutral100,
          ),
          Container(
            decoration: BoxDecoration(color: neutralWhite),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(24),
            // alignment: Alignment.center,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('assets/images/apple_card.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: const Border(
                      left: BorderSide(
                        width: 2,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: mediumTS.copyWith(fontSize: 18),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Sumber: gdm.id',
                            style: TextStyle(
                                fontSize: 12,
                                color: neutral400,
                                fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Bagi para Dulur yang punya tanaman apel, pasti sudah tidak asing dengan penyakit busuk buah. Penyakit ini juga lazim dikenal sebagai \"mata ayam\". Sebab menimbulkan bercak bulat berwarna hitam dengan pinggiran berwarna merah. Mirip dengan mata ayam.\n\nPenyakit busuk buah pada apel menjadi momok tersendiri bagi petani apel. Pasalnya, masalah ini tak hanya menyerang satu atau dua buah apel saja, melainkan bisa menyebar ke seluruh pohon.\n\nDampaknya tentu saja merugikan. Buah yang harusnya sudah bisa panen terpaksa dibuang karena tidak layak jual. Akibatnya petani mengalami kerugian baik secara tenaga maupun biaya.\n\nUntuk mengantisipasi penyakit ini, Dulur perlu memahami penyebab serta cara penanganannya. Agar masalah dapat diselesaikan hingga ke akarnya.")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
