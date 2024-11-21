import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DetailpenyakitPage extends StatelessWidget {
  final String title;
  const DetailpenyakitPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: Icon(IconsaxPlusLinear.trash),
                  color: redBase,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: 'Hapus riwayat ini?',
                      subtitle:
                          'Semua informasi yang terkait dengan diagnosis ini akan hilang.',
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                isDialogButton: true,
                                text: 'Hapus',
                                backgroundColor: redBase,
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: CustomButton(
                                isDialogButton: true,
                                text: 'Batal',
                                backgroundColor: neutralWhite,
                                borderColor: neutral100,
                                textColor: neutralBlack,
                                onTap: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(color: neutralWhite),
            child: ListView(
              children: [
                Divider(
                  height: 1,
                  color: neutral100,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              constraints: BoxConstraints(maxHeight: 230),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/apple_card.png'),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: neutral50,
                              border: Border.all(color: neutral100),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Terjangkit $title',
                                  style: mediumTS.copyWith(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Lihat diagnosis untuk detail gejala dan penanganan',
                                  style: regularTS.copyWith(color: neutral400),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: TabBar(
                              labelPadding: EdgeInsets.symmetric(horizontal: 6),
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              dividerHeight: 0,
                              labelColor: green700,
                              indicatorColor: green700,
                              indicatorSize: TabBarIndicatorSize.label,
                              unselectedLabelColor: neutral400,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Definisi',
                                    style: mediumTS.copyWith(fontSize: 16),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Gejala',
                                    style: mediumTS.copyWith(fontSize: 16),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Solusi',
                                    style: mediumTS.copyWith(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 300, // Tinggi tetap untuk TabBarView
                            child: TabBarView(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "Fire blight adalah penyakit bakteri yang disebabkan oleh Erwinia amylovora, yang terutama menyerang pohon apel dan pir. Penyakit ini menyebabkan daun dan ranting tampak seperti terbakar, sehingga disebut \"fire blight.\"",
                                    style: regularTS.copyWith(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "Gejalanya adalah daun dan ranting terlihat hitam dan seperti terbakar, terutama di musim semi.",
                                    style: regularTS.copyWith(color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "Solusinya meliputi pemangkasan ranting yang terinfeksi dan penggunaan antibiotik berbasis streptomisin pada tahap awal infeksi.",
                                    style: regularTS.copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
