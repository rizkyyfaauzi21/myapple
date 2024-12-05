import 'dart:io';

import 'package:apple_leaf/configs/theme.dart';
import 'package:apple_leaf/widgets/custom_appbar.dart';
import 'package:apple_leaf/widgets/custom_button.dart';
import 'package:apple_leaf/widgets/custom_dialog.dart';
import 'package:apple_leaf/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/widgets/history/detail_penyakit_tab.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatelessWidget {
  final String title;
  final XFile image;
  const ScanPage({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final koleksiController = TextEditingController();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: customAppBar(
          context,
          actions: [
            TextButton(
                onPressed: () => handleSimpanPenyakit(context, koleksiController),
                child: Text(
                  'Simpan',
                  style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
                ))
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
                      image: DecorationImage(
                        image: FileImage(File(image.path)),
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

  Future<void> handleSimpanPenyakit(
    BuildContext context,
    TextEditingController koleksiController,
  ) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: neutralWhite,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 37),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum',
                style: mediumTS.copyWith(fontSize: 18, color: neutralBlack),
              ),
              Text(
                'lorem Ipsum Dolor Sit Amet',
                style: regularTS.copyWith(fontSize: 14, color: neutral400),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Koleksimu',
                    style: mediumTS.copyWith(fontSize: 18, color: neutralBlack),
                  ),
                  GestureDetector(
                    onTap: () => handleKoleksiBaru(context, koleksiController),
                    child: Text(
                      'Koleksi Baru',
                      style: mediumTS.copyWith(fontSize: 12, color: green700),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(File(image.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apel 1',
                        style: mediumTS.copyWith(fontSize: 16, color: neutralBlack),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Terakhir discan 1 hari yang lalu',
                        style: regularTS.copyWith(fontSize: 14, color: neutral400),
                      )
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(IconsaxPlusLinear.add_circle),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> handleKoleksiBaru(
    BuildContext context,
    TextEditingController koleksiController,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomForm(
                title: 'Nama Koleksi',
                controller: koleksiController,
                keyboardType: TextInputType.name,
                hint: 'Masukkan Nama Koleksi',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
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
                  const SizedBox(width: 4),
                  Expanded(
                    child: CustomButton(
                      isDialogButton: true,
                      text: 'Simpan',
                      backgroundColor: green700,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
