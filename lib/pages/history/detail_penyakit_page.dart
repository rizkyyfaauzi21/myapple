import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/widgets/history/detail_penyakit_tab.dart';
import 'package:apple_leaf/provider/disease_provider.dart';

class DetailPenyakitPage extends StatelessWidget {
  final String title;
  final String image;
  const DetailPenyakitPage({
    super.key,
    required this.title,
    required this.image,
  });

  int getDiseaseId() {
    switch (title) {
      case 'Scab':
        return 1;
      case 'Rust':
        return 2;
      case 'Healthy':
        return 3;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final diseaseId = getDiseaseId();
    final disease = diseaseDetails[diseaseId];

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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'http://10.0.2.2:8000/storage/images/apples/$image',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: neutral100,
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title of Penyakit
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
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
                      labelStyle:
                          mediumTS.copyWith(fontSize: 16, color: green700),
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
            Expanded(
              child: TabBarView(
                children: [
                  DetailPenyakitTab(
                    text: disease?.description ?? 'No description available',
                  ),
                  DetailPenyakitTab(
                    text: disease?.symptoms ?? 'No symptoms available',
                  ),
                  DetailPenyakitTab(
                    text: disease?.treatment ?? 'No treatment available',
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
    );
  }
}
