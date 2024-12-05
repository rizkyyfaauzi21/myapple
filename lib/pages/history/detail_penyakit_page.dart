import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/widgets/history/detail_penyakit_tab.dart';

class DetailPenyakitPage extends StatelessWidget {
  final String title;
  const DetailPenyakitPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: customAppBar(
          context,
          actions: [
            IconButton(
              onPressed: () => handleDeleteRiwayat(context),
              icon: const Icon(IconsaxPlusLinear.trash),
              color: redBase,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Image of Penyakit
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxHeight: 230),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/apple_card.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title of Penyakit
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: neutralWhite,
                      border: Border.all(color: neutral100),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Terjangkit $title',
                          style: mediumTS.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lihat diagnosis untuk detail gejala dan penanganan',
                          style: regularTS.copyWith(color: neutral400),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tab Bar
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: green700,
                      overlayColor: const MaterialStatePropertyAll(green50),
                      labelStyle: mediumTS.copyWith(fontSize: 16, color: green700),
                      unselectedLabelStyle:
                          mediumTS.copyWith(fontSize: 16, color: neutral400),
                      tabs: const [
                        Tab(child: Text('Definisi')),
                        Tab(child: Text('Gejala')),
                        Tab(child: Text('Solusi')),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar View
            const Expanded(
              child: TabBarView(
                children: [
                  DetailPenyakitTab(
                    text:
                        "Fire blight adalah penyakit bakteri yang disebabkan oleh Erwinia amylovora, yang terutama menyerang pohon apel dan pir. Penyakit ini menyebabkan daun dan ranting tampak seperti terbakar, sehingga disebut \"fire blight.\"",
                  ),
                  DetailPenyakitTab(
                    text:
                        "Gejalanya adalah daun dan ranting terlihat hitam dan seperti terbakar, terutama di musim semi.",
                  ),
                  DetailPenyakitTab(
                    text:
                        "Solusinya meliputi pemangkasan ranting yang terinfeksi dan penggunaan antibiotik berbasis streptomisin pada tahap awal infeksi.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleDeleteRiwayat(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Hapus riwayat ini?',
        subtitle: 'Semua informasi yang terkait dengan diagnosis ini akan hilang.',
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
    );
  }
}
